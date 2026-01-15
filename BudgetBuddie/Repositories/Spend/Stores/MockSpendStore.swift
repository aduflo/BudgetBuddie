//
//  MockSpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class MockSpendStore: SpendStoreable {
    func getItems() throws -> [SpendItem_Data] {
        let date = Date()
        return (0..<20).map { idx in
            SpendItem_Data(
                id: UUID(),
                amount: Decimal(idx),
                note: (idx % 2 == 0) ? "Item #: \(idx)" : nil,
                date: date,
                createdAt: date
            )
        }
    }
    
    func getItems(date: Date) throws -> [SpendItem_Data] {
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
    
    func getItems(dates: [Date]) throws -> [SpendItem_Data] {
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
    
    func getDay(date: Date) throws -> SpendDay_Data {
        SpendDay_Data(
            id: UUID(),
            date: date,
            items: try getItems(date: date)
        )
    }
    
    func getAllMonths() throws -> [SpendMonth_Data] {
        (0..<20).map { idx in
            SpendMonth_Data(
                id: UUID(),
                month: 01,
                year: 2026,
                spend: Decimal(idx),
                allowance: 1337.00
            )
        }
    }
    
    func getPreviousMonth() throws -> SpendMonth_Data {
        SpendMonth_Data(
            id: UUID(),
            month: 01,
            year: 2026,
            spend: 9001.00,
            allowance: 9000.00
        )
    }
    
    private(set) var saveMonth_value: SpendMonth_Data? = nil
    func saveMonth(_ month: SpendMonth_Data) throws {
        saveMonth_value = month
    }
    
    private(set) var prepForMonth_flag: Bool = false
    func prepForMonth(_ date: Date) throws {
        prepForMonth_flag = true
    }
    
    private(set) var deletePreviousMonthData_flag: Bool = false
    func deletePreviousMonthData() {
        deletePreviousMonthData_flag = true
    }
}
