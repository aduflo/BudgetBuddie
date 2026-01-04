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
            id: UUID(),
            date: date,
            items: []
        )
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem] {
        (0..<10).map { item in
            SpendItem(
                id: UUID(),
                amount: Decimal(item),
                description: (item % 2 == 0) ? "Item #: \(item)" : nil,
                date: date
            )
        }
    }
    
    func getAllSpendItems(date: Date) throws -> [SpendItem] {
        let monthDays = Calendar.current.monthDatesFor(date)
        return monthDays.compactMap { date in
            let dayString = date.formatted(.dateTime.day(.twoDigits))
            guard let day = Int(dayString) else {
                return nil
            }
            
            return SpendItem(
                id: UUID(),
                amount: Decimal(day),
                description: (day % 2 == 0) ? "Day #: \(day)" : nil,
                date: date
            )
        }
    }
    
    func saveItem(_ item: SpendItem) throws {
        print("\(String(describing: Self.self))-\(#function)-id: \(item.id.uuidString)")
    }
    
    func deleteItem(_ item: SpendItem) throws {
        print("\(String(describing: Self.self))-\(#function)-id: \(item.id.uuidString)")
    }
    
    func prepStoreForMonth(_ dates: [Date]) {
        print("\(String(describing: Self.self))-\(#function)-dates: \(String(describing: dates))")
    }
    
    func purgeStore() {
        print("\(String(describing: Self.self))-\(#function)")
    }
}
