//
//  OnDiskSpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation
import SwiftData

class OnDiskSpendStore: SpendStoreable {
    // Instance vars
    private let container: ModelContainer? = {
        try? ModelContainer(
            for: SpendDay_SD.self,
            SpendItem_SD.self,
            configurations: ModelConfiguration()
        )
    }()
    private var context: ModelContext? {
        container?.mainContext
    }
    
    // SpendStoreable
    func getSpendDay(date: Date) throws -> SpendDay {
        try getSpendDay_SD(
            date: date
        ).spendDay
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem] {
        do {
            let day = try getSpendDay(
                date: date
            )
            return day.items
        } catch {
            throw SpendStoreError.spendItemsNotFound
        }
    }
    
    func getAllSpendItems(date: Date) throws -> [SpendItem] {
        let monthDates = CalendarService.monthDates(date)
        var items: [SpendItem] = []
        for date in monthDates {
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
    
    func saveItem(_ item: SpendItem) throws {
        do {
            // get day associated with item.date
            let day = try getSpendDay_SD(
                date: item.date
            )
            
            // transform into SwiftData model
            let item_sd = SpendItem_SD(
                spendItem: item
            )
            
            // save item to items
            var items = day.items
            var oldItem: SpendItem_SD? // need to hold onto old model object
            if let matchingIdx = items.firstIndex(
                where: { $0.id == item_sd.id }
            ) {
                oldItem = items.remove(at: matchingIdx)
                items.insert(item_sd, at: matchingIdx)
            } else {
                items.append(item_sd)
            }
            
            // update context
            try context?.transaction {
                if let oldItem {
                    // delete old model object to prevent .id collision
                    // given items are bound to .id
                    context?.delete(oldItem)
                }
                day.setItems(items)
            }
        } catch {
            throw SpendStoreError.unableToSaveItem
        }
    }
    
    func deleteItem(_ item: SpendItem) throws {
        do {
            // get day associated with item.date
            let day = try getSpendDay_SD(
                date: item.date
            )
            
            // delete item to items
            var items = day.items
            if let matchingIdx = items.firstIndex(
                where: { $0.id == item.id
                }
            ) {
                items.remove(at: matchingIdx)
            }
            
            // update context
            try context?.transaction {
                day.setItems(items)
            }
        } catch {
            throw SpendStoreError.unableToDeleteItem
        }
    }
    
    func prepStoreForMonth(_ dates: [Date]) {
        do {
            try context?.transaction {
                for date in dates {
                    context?.insert(
                        SpendDay_SD(
                            date: date,
                            key: dateStringKey(date),
                            items: []
                        )
                    )
                }
            }
        } catch {}
    }
    
    func purgeStore() {
        do {
            try context?.transaction {
                try context?.delete(
                    model: SpendDay_SD.self
                )
            }
        } catch {}
    }
}

// MARK: Private interface
private extension OnDiskSpendStore {
    func dateStringKey(_ date: Date) -> String {
        date.monthDayYearString
    }
    
    func getSpendDay_SD(date: Date) throws -> SpendDay_SD {
        let key = dateStringKey(date)
        let predicate: Predicate<SpendDay_SD> = #Predicate { spendDay in
            spendDay.key == key
        }
        let descriptor = FetchDescriptor<SpendDay_SD>(
            predicate: predicate
        )
        let spendDays = try context?.fetch(descriptor)
        
        guard let firstDay = spendDays?.first else {
            throw SpendStoreError.spendDayNotFound
        }
        
        return firstDay
    }
}
