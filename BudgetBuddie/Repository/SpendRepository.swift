//
//  SpendRepository.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

@Observable
class SpendRepository: SpendStoreable {
    // Instance vars
    private let spendStore: SpendStoreable
    let calendarService: CalendarServiceable
    
    // Constructors
    init(
        spendStore: SpendStoreable,
        calendarService: CalendarServiceable
    ) {
        self.spendStore = spendStore
        self.calendarService = calendarService
        setup()
    }

    // SpendStoreable
    func getSpendDay(date: Date) throws -> SpendDay {
        try spendStore.getSpendDay(date: date)
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem] {
        try spendStore.getSpendItems(date: date)
    }
    
    func saveItem(_ item: SpendItem) throws {
        try spendStore.saveItem(item)
    }
    
    func deleteItem(_ item: SpendItem) throws {
        try spendStore.deleteItem(item)
    }
    
    func prepStoreForMonth(_ dates: [Date]) {
        spendStore.prepStoreForMonth(dates)
    }
    
    func purgeStore() {
        spendStore.purgeStore()
    }
}

// MARK: Private interface
private extension SpendRepository {
    func setup() {
        let date = calendarService.selectedDate
        do {
            _ = try getSpendDay(date: date)
        } catch {
            if case .spendDayNotFound = error as? SpendStoreError {
                // if we cannot find a SpendDay associated with today's date
                // we can conclude we are in a different month
                // because no SpendDay stored has a `date` value that overlaps
                // thus, we purge the store + prep store for month matching today's date
                purgeStore()
                prepStoreForMonth(calendarService.monthDates(date))
            }
        }
    }
}
