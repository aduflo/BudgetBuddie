//
//  SpendRepository.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class SpendRepository: SpendRepositable {
    // Instance vars
    private let store: SpendStoreable = {
        SwiftDataSpendStore()
//        InMemorySpendStore()
    }()
    private var didSetupOnce: Bool {
        UserDefaults.standard.bool(
            forKey: UserDefaults.Key.SpendRepository.didSetupOnce
        )
    }
    
    func setup(settingsService: any SettingsServiceable) {
        if didSetupOnce {
            standardSetup(
                settingsService: settingsService
            )
        } else {
            initialSetup()
        }
    }

    // SpendRepositable
    func getItems(date: Date) throws -> [SpendItem] {
        let items_data = try store.getItems(date: date)
        let items = items_data.map { SpendItemMapper.toDomainObject($0) }
        return items
    }
    
    func getItems(dates: [Date]) throws -> [SpendItem] {
        let items_data = try store.getItems(
            dates: dates
        )
        let items = items_data.map { SpendItemMapper.toDomainObject($0) }
        return items
    }
    
    func saveItem(_ item: SpendItem) throws {
        let item_data = SpendItemMapper.toDataObject(item)
        try store.saveItem(item_data)
        postNotificationSpendRepositoryDidUpdateItem()
    }
    
    func deleteItem(_ item: SpendItem) throws {
        let item_data = SpendItemMapper.toDataObject(item)
        try store.deleteItem(item_data)
        postNotificationSpendRepositoryDidUpdateItem()
    }
    
    func getDay(date: Date) throws -> SpendDay {
        let day_data = try store.getDay(date: date)
        let day = SpendDayMapper.toDomainObject(day_data)
        return day
    }
    
    func getAllMonths() throws -> [SpendMonth] {
        let months_data = try store.getAllMonths()
        let months = months_data.map { SpendMonthMapper.toDomainObject($0) }
        return months
    }
    
    func getMonth(month: Int, year: Int) throws -> SpendMonth {
        let month_data = try store.getMonth(
            month: month,
            year: year
        )
        let month = SpendMonthMapper.toDomainObject(month_data)
        return month
    }
}

// MARK: Private interface
private extension SpendRepository {
    // Setup
    func initialSetup() {
        do {
            try stageNewMonth(Date())
            UserDefaults.standard.set(
                true,
                forKey: UserDefaults.Key.SpendRepository.didSetupOnce
            )
        } catch {}
    }
    
    func standardSetup(settingsService: any SettingsServiceable) {
        let date = Date()
        do {
            _ = try getDay(date: date)
//            store.commitMultipleMonths()
//            store.purgeAllMonths()
            postNotificationSpendRepositoryDidCommitStagedMonth( // TODO: remove after testing
                month: 03,
                year: 2025
            )
        } catch {
            if case .dayNotFound = error as? SpendStoreError {
                // if we cannot find a SpendDay associated with today's date
                // we can conclude we are in a different month
                // because no SpendDay stored has a `date` value that overlaps with today's date
                // thus, we:
                // - commit staged month to store
                // - stage new month matching today's date
                do {
                    try commitStagedMonth(
                        settingsService: settingsService
                    )
                    try stageNewMonth(date)
                } catch {}
            }
        }
    }
    
    // Stage/commit month
    func commitStagedMonth(settingsService: SettingsServiceable) throws {
        // compose month_data
        let items = try store.getAllItems()
        let spend = items.reduce(0.0, { $0 + $1.amount })
        let allowance = settingsService.monthlyAllowance
        let calendar = Calendar.current
        let month = calendar.month
        let year = calendar.year
        let month_data = SpendMonth_Data(
            id: UUID(),
            month: month,
            year: year,
            spend: spend,
            allowance: allowance
        )
        
        // save month_data
        try store.saveMonth(month_data)
        
        // post notification
        postNotificationSpendRepositoryDidCommitStagedMonth(
            month: month,
            year: year
        )
    }
    
    func stageNewMonth(_ date: Date) throws {
        // firstly, delete staged month data
        try store.deleteStagedMonthData()
        
        // secondly, have store stage data for month matching date
        try store.stageMonthData(date)
        
        // lastly, post notification
        postNotificatioSpendRepositoryDidStageNewMonth()
    }
    
    // Notifications
    func postNotificationSpendRepositoryDidUpdateItem() {
        NotificationCenter.default.post(.SpendRepositoryDidUpdateItem)
    }
    
    func postNotificatioSpendRepositoryDidStageNewMonth() {
        NotificationCenter.default.post(.SpendRepositoryDidStageNewMonth)
    }
    
    func postNotificationSpendRepositoryDidCommitStagedMonth(month: Int, year: Int) {
        NotificationCenter.default.post(
            name: .SpendRepositoryDidCommitStagedMonth,
            object: nil,
            userInfo: [
                Notification.UserInfoKey.month: month,
                Notification.UserInfoKey.year: year
            ]
        )
    }
}
