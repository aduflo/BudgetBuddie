//
//  MockSpendRepository.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

class MockSpendRepository: SpendRepositable {
    // SpendRepositable
    func setup(calendarService: any CalendarServiceable, settingsService: any SettingsServiceable) throws {}
    
    func getItems(date: Date) throws -> [SpendItem] {
        [.mock()]
    }
    
    func getItems(dates: [Date]) throws -> [SpendItem] {
        [.mock()]
    }
    
    private(set) var saveItem_value: SpendItem? = nil
    func saveItem(_ item: SpendItem) throws {
        saveItem_value = item
    }
    
    private(set) var deleteItem_value: SpendItem? = nil
    func deleteItem(_ item: SpendItem) throws {
        deleteItem_value = item
    }
    
    func getDay(date: Date) throws -> SpendDay {
        .mock()
    }
    
    var getAllMonths_returnValue: (months: [SpendMonth]?, error: Error?)? = nil
    func getAllMonths() throws -> [SpendMonth] {
        let returnValue = getAllMonths_returnValue
        if let months = returnValue?.months {
            return months
        } else if let error = returnValue?.error {
            throw error
        }
        return [.mock()]
    }
    
    var getMonth_returnValue: (spendMonth: SpendMonth?, error: Error?)? = nil
    func getMonth(date: Date) throws -> SpendMonth {
        let returnValue = getMonth_returnValue
        if let spendMonth = returnValue?.spendMonth {
            return spendMonth
        } else if let error = returnValue?.error {
            throw error
        }
        
        return .mock()
    }
}
