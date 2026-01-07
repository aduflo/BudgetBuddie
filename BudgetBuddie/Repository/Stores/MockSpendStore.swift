//
//  MockSpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class MockSpendStore: SpendStoreable {
    func getSpendDay(date: Date) throws -> SpendDay {
        SpendDay(
            date: date,
            items: []
        )
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem] {
        (0..<10).map { item in
            SpendItem(
                amount: Decimal(item),
                note: (item % 2 == 0) ? "Item #: \(item)" : nil,
                date: date
            )
        }
    }
    
    func getAllSpendItems(date: Date) throws -> [SpendItem] {
        let monthDays = MockCalendarService.monthDates(date)
        return monthDays.compactMap { date in
            let dayString = date.formatted(.dateTime.day(.twoDigits))
            guard let day = Int(dayString) else {
                return nil
            }
            
            return SpendItem(
                amount: Decimal(day),
                note: (day % 2 == 0) ? "Day #: \(day)" : nil,
                date: date
            )
        }
    }
    
    private(set) var saveItem_value: SpendItem? = nil
    func saveItem(_ item: SpendItem) throws {
        saveItem_value = item
    }
    
    private(set) var deleteItem_value: SpendItem? = nil
    func deleteItem(_ item: SpendItem) throws {
        deleteItem_value = item
    }
    
    private(set) var prepStoreForMonth_flag: Bool = false
    func prepStoreForMonth(_ dates: [Date]) {
        prepStoreForMonth_flag = true
    }
    
    private(set) var purgeStore_flag: Bool = false
    func purgeStore() {
        purgeStore_flag = true
    }
}
