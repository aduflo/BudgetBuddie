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
    
    var getItemsForDate_returnValue: (items: [SpendItem]?, error: SpendRepositoryError?)? = nil
    func getItems(date: Date) throws -> [SpendItem] {
        let returnValue = getItemsForDate_returnValue
        if let items = returnValue?.items {
            return items
        } else if let error = returnValue?.error {
            throw error
        }
        return [.mock()]
    }
    
    var getItemsForDates_returnValue: (items: [SpendItem]?, error: SpendRepositoryError?)? = nil
    func getItems(dates: [Date]) throws -> [SpendItem] {
        let returnValue = getItemsForDates_returnValue
        if let items = returnValue?.items {
            return items
        } else if let error = returnValue?.error {
            throw error
        }
        return [.mock()]
    }
    
    var saveItem_throwValue: SpendRepositoryError? = nil
    private(set) var saveItem_value: SpendItem? = nil
    func saveItem(_ item: SpendItem) throws {
        if let saveItem_throwValue {
            throw saveItem_throwValue
        }
        
        saveItem_value = item
    }
    
    var deleteItem_throwValue: SpendRepositoryError? = nil
    private(set) var deleteItem_value: SpendItem? = nil
    func deleteItem(_ item: SpendItem) throws {
        if let deleteItem_throwValue {
            throw deleteItem_throwValue
        }
        
        deleteItem_value = item
    }
    
    var getDayForDate_returnValue: (day: SpendDay?, error: SpendRepositoryError?)? = nil
    func getDay(date: Date) throws -> SpendDay {
        let returnValue = getDayForDate_returnValue
        if let day = returnValue?.day {
            return day
        } else if let error = returnValue?.error {
            throw error
        }
        
        return .mock()
    }
    
    var getDayForId_returnValue: (day: SpendDay?, error: SpendRepositoryError?)? = nil
    func getDay(id: UUID) throws -> SpendDay {
        let returnValue = getDayForId_returnValue
        if let day = returnValue?.day {
            return day
        } else if let error = returnValue?.error {
            throw error
        }
        
        return .mock()
    }
    
    var getAllMonths_returnValue: (months: [SpendMonth]?, error: SpendRepositoryError?)? = nil
    func getAllMonths() throws -> [SpendMonth] {
        let returnValue = getAllMonths_returnValue
        if let months = returnValue?.months {
            return months
        } else if let error = returnValue?.error {
            throw error
        }
        return [.mock()]
    }
    
    var getMonth_returnValue: (spendMonth: SpendMonth?, error: SpendRepositoryError?)? = nil
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
