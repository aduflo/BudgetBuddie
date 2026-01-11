//
//  InMemorySpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/31/25.
//

import Foundation
import Synchronization

class InMemorySpendStore: SpendStoreable {
    // Instance vars
    typealias DateString = String
    private let daysDict = Mutex<[DateString: SpendDay_Data]>([:])
    
    // SpendStoreable
    func getSpendDay(date: Date) throws -> SpendDay_Data {
        try daysDict.withLock { daysDict in
            guard let day = daysDict[dateStringKey(date)] else {
                throw SpendStoreError.spendDayNotFound
            }
            
            return day
        }
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem_Data] {
        do {
            let day = try getSpendDay(
                date: date
            )
            return day.items
        } catch {
            throw SpendStoreError.spendItemsNotFound
        }
    }
    
    func getSpendItems(dates: [Date]) throws -> [SpendItem_Data] {
        var items: [SpendItem_Data] = []
        for date in dates {
            do {
                items.append(
                    contentsOf: try getSpendItems(
                        date: date
                    )
                )
            } catch {
                throw SpendStoreError.spendItemsNotFound
            }
        }
        return items
    }
    
    func saveItem(_ item: SpendItem_Data) throws {
        do {
            let date = item.date
            
            // get day associated with date
            let day = try getSpendDay(
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
                items: items,
                key: nil
            )
            daysDict.withLock { daysDict in
                daysDict[dateStringKey(date)] = newDay
            }
        } catch {
            throw SpendStoreError.unableToSaveItem
        }
    }
    
    func deleteItem(_ item: SpendItem_Data) throws {
        do {
            let date = item.date
            
            // get day
            let day = try getSpendDay(
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
                items: items,
                key: nil
            )
            daysDict.withLock { daysDict in
                daysDict[dateStringKey(date)] = newDay
            }
        } catch {
            throw SpendStoreError.unableToDeleteItem
        }
    }
    
    func prepStoreForMonth(_ dates: [Date]) {
        daysDict.withLock { daysDict in
            for date in dates {
                daysDict[dateStringKey(date)] = SpendDay_Data(
                    id: UUID(),
                    date: date,
                    items: [],
                    key: nil
                )
            }
        }
    }
    
    func purgeStore() {
        daysDict.withLock { $0 = [:] }
    }
}

// MARK: Private interface
private extension InMemorySpendStore {
    func dateStringKey(_ date: Date) -> String {
        date.monthDayYearString
    }
}
