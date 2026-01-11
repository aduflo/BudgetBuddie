//
//  MockSpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class MockSpendStore: SpendStoreable {
    func getSpendDay(date: Date) throws -> SpendDay_Data {
        SpendDay_Data(
            id: UUID(),
            date: date,
            items: try getSpendItems(date: date)
        )
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem_Data] {
        (0..<10).map { idx in
            SpendItem_Data(
                id: UUID(),
                amount: Decimal(idx),
                note: (idx % 2 == 0) ? "Item #: \(idx)" : nil,
                date: date,
                createdAt: Date()
            )
        }
    }
    
    func getSpendItems(dates: [Date]) throws -> [SpendItem_Data] {
        return dates.compactMap { date in
            let dayString = date.formatted(.dateTime.day(.twoDigits))
            guard let day = Int(dayString) else {
                return nil
            }
            
            return SpendItem_Data(
                id: UUID(),
                amount: Decimal(day),
                note: (day % 2 == 0) ? "Day #: \(day)" : nil,
                date: date,
                createdAt: date
            )
        }
    }
    
    private(set) var saveItem_value: SpendItem_Data? = nil
    func saveItem(_ item: SpendItem_Data) throws {
        saveItem_value = item
    }
    
    private(set) var deleteItem_value: SpendItem_Data? = nil
    func deleteItem(_ item: SpendItem_Data) throws {
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
