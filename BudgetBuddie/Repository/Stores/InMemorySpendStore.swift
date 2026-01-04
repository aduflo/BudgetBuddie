//
//  InMemorySpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/31/25.
//

import Foundation

class InMemorySpendStore: SpendStoreable {
    // Instance vars
    private var daysDict: [Date: SpendDay] = [:]
    
    // SpendStoreable
    func getSpendDay(date: Date) throws -> SpendDay {
        // FIXME: this is doing exact day.. no good. we need string representation such as yyyy/mm/dd
        guard let day = daysDict[date] else {
            throw SpendStoreError.spendDayNotFound
        }
        
        return day
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem] {
        do {
            let day = try getSpendDay(date: date)
            return day.items
        } catch {
            throw SpendStoreError.spendItemsNotFound
        }
    }
    
    func saveItem(_ item: SpendItem) throws {
        do {
            let date = item.date
            
            // get day
            let day = try getSpendDay(date: date)
            
            // save item to items
            var items = day.items
            if let matchingIdx = items.firstIndex(where: { $0.id == item.id }) {
                items.remove(at: matchingIdx)
                items.insert(item, at: matchingIdx)
            } else {
                items.append(item)
            }
            
            // replace day with newDay
            let newDay = SpendDay(
                id: day.id,
                date: day.date,
                items: items
            )
            daysDict[date] = newDay
        } catch {
            throw SpendStoreError.unableToSaveItem
        }
    }
    
    func deleteItem(_ item: SpendItem) throws {
        do {
            let date = item.date
            
            // get day
            let day = try getSpendDay(date: date)
            
            // delete item to items
            var items = day.items
            if let matchingIdx = items.firstIndex(where: { $0.id == item.id }) {
                items.remove(at: matchingIdx)
            }
            
            // replace day with newDay
            let newDay = SpendDay(
                id: day.id,
                date: day.date,
                items: items
            )
            daysDict[date] = newDay
        } catch {
            throw SpendStoreError.unableToSaveItem
        }
    }
    
    func prepStoreForMonth(_ dates: [Date]) {
        for date in dates {
            daysDict[date] = SpendDay(
                id: UUID(),
                date: date,
                items: []
            )
        }
    }
    
    func purgeStore() {
        daysDict = [:]
    }
}
