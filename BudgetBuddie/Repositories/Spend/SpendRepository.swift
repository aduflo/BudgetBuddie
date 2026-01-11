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
    
    func setup() {
        let date = Date() // today's date
        do {
            _ = try getSpendDay(date: date)
        } catch {
            if case .spendDayNotFound = error as? SpendStoreError {
                // if we cannot find a SpendDay associated with today's date
                // we can conclude we are in a different month
                // because no SpendDay stored has a `date` value that overlaps with today's date
                // thus, we purge the store + prep store for month matching today's date
                spendStore.purgeStore()
                let monthDates = CalendarService.monthDates(date)
                spendStore.prepStoreForMonth(monthDates)
                postNotificationSpendRepositoryUpdated()
            }
        }
    }

    // SpendRepositable
    func getSpendDay(date: Date) throws -> SpendDay {
        let day_data = try spendStore.getSpendDay(date: date)
        let day = SpendDayMapper.toDomainObject(day_data)
        return day
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem] {
        let items_data = try spendStore.getSpendItems(date: date)
        let items = items_data.map { SpendItemMapper.toDomainObject($0) }
        return items
    }
    
    func getSpendItems(dates: [Date]) throws -> [SpendItem] {
        let items_data = try spendStore.getSpendItems(
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
}

// MARK: Private interface
private extension SpendRepository {
    func postNotificationSpendRepositoryUpdated() {
        NotificationCenter.default.post(.SpendRepositoryUpdated)
    }
}
