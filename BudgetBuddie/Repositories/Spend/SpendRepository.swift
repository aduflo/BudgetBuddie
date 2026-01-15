//
//  SpendRepository.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class SpendRepository: SpendRepositable {
    // Instance vars
    private let spendStore: SpendStoreable = {
        SwiftDataSpendStore()
//        InMemorySpendStore()
    }()
    
    func setup(settingsService: any SettingsServiceable) {
        let date = Date() // today's date
        do {
            _ = try getDay(date: date)
        } catch {
            if case .dayNotFound = error as? SpendStoreError {
                // if we cannot find a SpendDay associated with today's date
                // we can conclude we are in a different month
                // because no SpendDay stored has a `date` value that overlaps with today's date
                // thus, we:
                // - save previous month to store
                // - prep store for month matching today's date
                // - post notification
                // TODO: - verify functionality around month persisting for new month
                do {
                    try savePreviousMonth(
                        settingsService: settingsService
                    )
                    try prepStoreForNewMonth(date)
                } catch {
                    print("\(#function)-error: \(error.localizedDescription)")
                }
                postNotificationSpendRepositoryUpdated()
            }
        }
    }

    // SpendRepositable
    func getItems(date: Date) throws -> [SpendItem] {
        let items_data = try spendStore.getItems(date: date)
        let items = items_data.map { SpendItemMapper.toDomainObject($0) }
        return items
    }
    
    func getItems(dates: [Date]) throws -> [SpendItem] {
        let items_data = try spendStore.getItems(
            dates: dates
        )
        let items = items_data.map { SpendItemMapper.toDomainObject($0) }
        return items
    }
    
    func saveItem(_ item: SpendItem) throws {
        let item_data = SpendItemMapper.toDataObject(item)
        try spendStore.saveItem(item_data)
        postNotificationSpendRepositoryUpdated()
    }
    
    func deleteItem(_ item: SpendItem) throws {
        let item_data = SpendItemMapper.toDataObject(item)
        try spendStore.deleteItem(item_data)
        postNotificationSpendRepositoryUpdated()
    }
    
    func getDay(date: Date) throws -> SpendDay {
        let day_data = try spendStore.getDay(date: date)
        let day = SpendDayMapper.toDomainObject(day_data)
        return day
    }
    
    func getAllMonths() throws -> [SpendMonth] {
        let months_data = try spendStore.getAllMonths()
        let months = months_data.map { SpendMonthMapper.toDomainObject($0) }
        return months
    }
    
    func getPreviousMonth() throws -> SpendMonth {
        let previousMonth_data = try spendStore.getPreviousMonth()
        let previousMonth = SpendMonthMapper.toDomainObject(previousMonth_data)
        return previousMonth
    }
}

// MARK: Private interface
private extension SpendRepository {
    func postNotificationSpendRepositoryUpdated() {
        NotificationCenter.default.post(.SpendRepositoryUpdated)
    }
    
    func savePreviousMonth(settingsService: SettingsServiceable) throws {
        let items = try spendStore.getItems()
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
        try spendStore.saveMonth(month_data)
    }
    
    func prepStoreForNewMonth(_ date: Date) throws {
        // firstly, delete previous month data
        try spendStore.deletePreviousMonthData()
        
        // prep store for month matching date
        try spendStore.prepForMonth(date)
    }
}
