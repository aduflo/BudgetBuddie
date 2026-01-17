//
//  InMemorySpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/31/25.
//

import Foundation
import Synchronization

class InMemorySpendStore: SpendStoreable {
    // TODO: remove after testing
//    func commitMultipleMonths() {}
//    func purgeAllMonths() {}
    
    // Instance vars
    private let daysDict = Mutex<[String: SpendDay_Data]>([:])
    
    // SpendStoreable
    func getAllItems() throws -> [SpendItem_Data] {
        let days_data = daysDict.withLock { daysDict in
            daysDict.values
        }
        var items_data: [SpendItem_Data] = []
        for day_data in days_data {
            items_data.append(
                contentsOf: day_data.items
            )
        }
        return items_data
    }
    
    func getItems(date: Date) throws -> [SpendItem_Data] {
        do {
            let day = try getDay(
                date: date
            )
            return day.items
        } catch {
            throw SpendStoreError.itemsNotFound
        }
    }
    
    func getItems(dates: [Date]) throws -> [SpendItem_Data] {
        var items: [SpendItem_Data] = []
        for date in dates {
            do {
                items.append(
                    contentsOf: try getItems(
                        date: date
                    )
                )
            } catch {
                throw SpendStoreError.itemsNotFound
            }
        }
        return items
    }
    
    func saveItem(_ item: SpendItem_Data) throws {
        do {
            let date = item.date
            
            // get day associated with date
            let day = try getDay(
                date: date
            )
            
            // save item to items
            var items = day.items
            if let matchingIdx = items.firstIndex(where: { $0.id == item.id }) {
                items.remove(at: matchingIdx)
                items.insert(item, at: matchingIdx)
            } else {
                items.append(item)
            }
            
            // replace day with newDay
            let newDay = SpendDay_Data(
                id: day.id,
                date: day.date,
                items: items
            )
            daysDict.withLock { daysDict in
                daysDict[spendDayKey(date)] = newDay
            }
        } catch {
            throw SpendStoreError.unableToSaveItem
        }
    }
    
    func deleteItem(_ item: SpendItem_Data) throws {
        do {
            let date = item.date
            
            // get day
            let day = try getDay(
                date: date
            )
            
            // delete item to items
            var items = day.items
            if let matchingIdx = items.firstIndex(where: { $0.id == item.id }) {
                items.remove(at: matchingIdx)
            }
            
            // replace day with newDay
            let newDay = SpendDay_Data(
                id: day.id,
                date: day.date,
                items: items
            )
            daysDict.withLock { daysDict in
                daysDict[spendDayKey(date)] = newDay
            }
        } catch {
            throw SpendStoreError.unableToDeleteItem
        }
    }
    
    func getDay(date: Date) throws -> SpendDay_Data {
        try daysDict.withLock { daysDict in
            guard let day = daysDict[spendDayKey(date)] else {
                throw SpendStoreError.dayNotFound
            }
            
            return day
        }
    }
    
    func getAllMonths() throws -> [SpendMonth_Data] {
        throw notImplementedError(functionName: #function)
    }
    
    func getMonth(month: Int, year: Int) throws -> SpendMonth_Data {
        throw notImplementedError(functionName: #function)
    }
    
    func saveMonth(_ month: SpendMonth_Data) throws {
        throw notImplementedError(functionName: #function)
    }
    
    func deleteStagedMonthData() throws {
        daysDict.withLock { $0 = [:] }
    }
    
    func stageMonthData(_ date: Date) throws {
        let dates = Calendar.current.monthDates(
            date
        )
        daysDict.withLock { daysDict in
            for date in dates {
                daysDict[spendDayKey(date)] = SpendDay_Data(
                    id: UUID(),
                    date: date,
                    items: []
                )
            }
        }
    }
}

// MARK: Private interface
private extension InMemorySpendStore {
    func spendDayKey(_ date: Date) -> String {
        SpendDayKey(date).value
    }
    
    func notImplementedError(functionName: String) -> SpendStoreError {
        let value = "\(String(describing: Self.self)).\(functionName)"
        return .notImplemented(value)
    }
}
