//
//  OnDiskSpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation
import SwiftData

class SwiftDataSpendStore: SpendStoreable {
    // Instance vars
    private let container: ModelContainer? = {
        try? ModelContainer(
            for: SpendDay_SwiftData.self,
            SpendItem_SwiftData.self,
            configurations: ModelConfiguration()
        )
    }()
    private var context: ModelContext? {
        container?.mainContext
    }
    
    // SpendStoreable
    func getSpendDay(date: Date) throws -> SpendDay_Data {
        let day_swiftData = try getSpendDay_SwiftData(
            date: date
        )
        let day_data = SpendDayMapper.toDataObject(day_swiftData)
        return day_data
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
            // get day associated with item.date
            let day = try getSpendDay_SwiftData(
                date: item.date
            )
            
            // transform into SwiftData model
            let item_swiftData = SpendItemMapper.toSwiftDataObject(item)
            
            // save item to items
            var items = day.items
            var oldItem: SpendItem_SwiftData? // need to hold onto old model object
            if let matchingIdx = items.firstIndex(
                where: { $0.id == item_swiftData.id }
            ) {
                oldItem = items.remove(at: matchingIdx)
                items.insert(item_swiftData, at: matchingIdx)
            } else {
                items.append(item_swiftData)
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
    
    func deleteItem(_ item: SpendItem_Data) throws {
        do {
            // get day associated with item.date
            let day = try getSpendDay_SwiftData(
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
                        SpendDay_SwiftData(
                            id: UUID(),
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
                    model: SpendDay_SwiftData.self
                )
            }
        } catch {}
    }
}

// MARK: Private interface
private extension SwiftDataSpendStore {
    func dateStringKey(_ date: Date) -> String {
        date.monthDayYearString
    }
    
    func getSpendDay_SwiftData(date: Date) throws -> SpendDay_SwiftData {
        let key = dateStringKey(date)
        let predicate: Predicate<SpendDay_SwiftData> = #Predicate { spendDay in
            spendDay.key == key
        }
        let descriptor = FetchDescriptor<SpendDay_SwiftData>(
            predicate: predicate
        )
        let spendDays = try context?.fetch(descriptor)
        
        guard let firstDay = spendDays?.first else {
            throw SpendStoreError.spendDayNotFound
        }
        
        return firstDay
    }
}
