//
//  MockSpendStore.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class MockSpendStore: SpendStoreable {
    // SpendStoreable
    var getItemsDayForDate_returnValue: (items: [SpendItem_Data]?, error: SpendStoreError?)? = nil
    func getItems(date: Date) throws -> [SpendItem_Data] {
        let returnValue = getItemsDayForDate_returnValue
        if let items = returnValue?.items {
            return items
        } else if let error = returnValue?.error {
            throw error
        }
        
        return (0..<10).map { idx in
            SpendItem_Data(
                id: UUID(),
                dayId: UUID(),
                amount: Decimal(idx),
                note: (idx % 2 == 0) ? "Item #: \(idx)" : nil,
                createdAt: Date()
            )
        }
    }
    
    var getItemsDayForDates_returnValue: (items: [SpendItem_Data]?, error: SpendStoreError?)? = nil
    func getItems(dates: [Date]) throws -> [SpendItem_Data] {
        let returnValue = getItemsDayForDates_returnValue
        if let items = returnValue?.items {
            return items
        } else if let error = returnValue?.error {
            throw error
        }
        
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
    
    var getDayForDate_returnValue: (day: SpendDay_Data?, error: SpendStoreError?)? = nil
    func getDay(date: Date) throws -> SpendDay_Data {
        let returnValue = getDayForDate_returnValue
        if let day = returnValue?.day {
            return day
        } else if let error = returnValue?.error {
            throw error
        }
        
        return .mock()
    }
    
    var getDayForId_returnValue: (day: SpendDay_Data?, error: SpendStoreError?)? = nil
    func getDay(id: UUID) throws -> SpendDay_Data {
        let returnValue = getDayForId_returnValue
        if let day = returnValue?.day {
            return day
        } else if let error = returnValue?.error {
            throw error
        }
        
        return .mock()
    }
    
    var getUncommittedDays_returnValue: (days: [SpendDay_Data]?, error: SpendStoreError?)? = nil
    func getUncommittedDays() throws -> [SpendDay_Data] {
        let returnValue = getUncommittedDays_returnValue
        if let days = returnValue?.days {
            return days
        } else if let error = returnValue?.error {
            throw error
        }
        
        return [.mock()]
    }
    
    var getAllMonths_returnValue: (months: [SpendMonth_Data]?, error: SpendStoreError?)? = nil
    func getAllMonths() throws -> [SpendMonth_Data] {
        let returnValue = getAllMonths_returnValue
        if let months = returnValue?.months {
            return months
        } else if let error = returnValue?.error {
            throw error
        }
        
        return [.mock()]
    }
    
    var getMonth_returnValue: (month: SpendMonth_Data?, error: SpendStoreError?)? = nil
    func getMonth(date: Date) throws -> SpendMonth_Data {
        let returnValue = getMonth_returnValue
        if let month = returnValue?.month {
            return month
        } else if let error = returnValue?.error {
            throw error
        }
        
        return .mock()
    }
    
    private(set) var commitMonth_value: SpendMonth_Data? = nil
    func commitMonth(_ month: SpendMonth_Data) throws {
        commitMonth_value = month
    }
    
    private(set) var stageMonthData_flag: Bool = false
    func stageMonthData(_ date: Date) throws {
        stageMonthData_flag = true
    }
}
