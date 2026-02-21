//
//  MockSpendStore.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class MockSpendStore: SpendStoreable {
    // SpendStoreable
    func getItems(date: Date) throws -> [SpendItem_Data] {
        (0..<10).map { idx in
            SpendItem_Data(
                id: UUID(),
                dayId: UUID(),
                amount: Decimal(idx),
                note: (idx % 2 == 0) ? "Item #: \(idx)" : nil,
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
                dayId: UUID(),
                amount: Decimal(day),
                note: (day % 2 == 0) ? "Day #: \(day)" : nil,
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
            items: try getItems(date: date),
            isCommitted: false
        )
    }
    
    func getDay(id: UUID) throws -> SpendDay_Data {
        SpendDay_Data(
            id: id,
            date: Date(),
            items: try getItems(date: Date()),
            isCommitted: false
        )
    }
    
    func getUncommittedDays() throws -> [SpendDay_Data] {
        [.mock()]
    }
    
    func getAllMonths() throws -> [SpendMonth_Data] {
        [.mock()]
    }
    
    func getMonth(date: Date) throws -> SpendMonth_Data {
        .mock()
    }
    
    private(set) var saveMonth_value: SpendMonth_Data? = nil
    func saveMonth(_ month: SpendMonth_Data) throws {
        saveMonth_value = month
    }
    
    private(set) var stageMonthData_flag: Bool = false
    func stageMonthData(_ date: Date) throws {
        stageMonthData_flag = true
    }
}
