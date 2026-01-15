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
    func getItems() throws -> [SpendItem_Data] {
        do {
            let fetchDescriptor = FetchDescriptor<SpendItem_SwiftData>()
            guard let items_swiftData = try context?.fetch(fetchDescriptor) else {
                throw SpendStoreError.itemsNotFound
            }
            
            let items_data = items_swiftData.map {
                SpendItemMapper.toDataObject($0)
            }
            return items_data
        } catch {
            throw SpendStoreError.itemsNotFound
        }
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
    
    func getDay(date: Date) throws -> SpendDay_Data {
        let day_swiftData = try getSpendDay_SwiftData(
            date: date
        )
        let day_data = SpendDayMapper.toDataObject(day_swiftData)
        return day_data
    }
    
    func getAllMonths() throws -> [SpendMonth_Data] {
        do {
            let yearSortDescriptor = SortDescriptor<SpendMonth_SwiftData>(\.year, order: .reverse) // TODO: validate .reverse is what we want
            let monthSortDescriptor = SortDescriptor<SpendMonth_SwiftData>(\.month, order: .reverse) // TODO: validate .reverse is what we want
            let fetchDescriptor = FetchDescriptor<SpendMonth_SwiftData>(
                sortBy: [
                    yearSortDescriptor,
                    monthSortDescriptor
                ]
            )
            let months_swiftData = try context?.fetch(fetchDescriptor) ?? []
            let months_data = months_swiftData.map {
                SpendMonthMapper.toDataObject($0)
            }
            return months_data
        } catch {
            throw SpendStoreError.monthsNotFound
        }
    }
    
    func getPreviousMonth() throws -> SpendMonth_Data {
        do {
            let months_data = try getAllMonths()
            guard let previousMonth = months_data.first else { // TODO: validate we're getting the previous month
                throw SpendStoreError.previousMonthNotFound
            }
            return previousMonth
        } catch {
            throw SpendStoreError.previousMonthNotFound
        }
    }
    
    func saveMonth(_ month: SpendMonth_Data) throws {
        do {
            let month_swiftData = SpendMonthMapper.toSwiftDataObject(month)
            try context?.transaction {
                context?.insert(month_swiftData)
            }
        } catch {
            throw SpendStoreError.unableToSaveMonth
        }
    }
    
    func prepForMonth(_ date: Date) throws {
        do {
            let dates = Calendar.current.monthDates(
                date
            )
            try context?.transaction {
                for date in dates {
                    context?.insert(
                        SpendDay_SwiftData(
                            id: UUID(),
                            date: date,
                            key: SpendDayKey(date).value,
                            items: []
                        )
                    )
                }
            }
        } catch {
            throw SpendStoreError.unableToPrepForMonth
        }
    }
    
    func deletePreviousMonthData() throws {
        do {
            // deleting all instances of SpendDay_SwiftData within context
            // due to [the aforementioned] relationship with SpendItem_SwiftData, all will also be deleted
            // given presence of delete rule: cascading
            try context?.transaction {
                try context?.delete(
                    model: SpendDay_SwiftData.self
                )
            }
        } catch {
            throw SpendStoreError.unableToDeletePreviousMonthData
        }
    }
}

// MARK: Private interface
private extension SwiftDataSpendStore {
    func getSpendDay_SwiftData(date: Date) throws -> SpendDay_SwiftData {
        let key = SpendDayKey(date).value
        let predicate: Predicate<SpendDay_SwiftData> = #Predicate { spendDay in
            spendDay.key == key
        }
        let descriptor = FetchDescriptor<SpendDay_SwiftData>(
            predicate: predicate
        )
        let spendDays = try context?.fetch(descriptor)
        
        guard let firstDay = spendDays?.first else {
            throw SpendStoreError.dayNotFound
        }
        
        return firstDay
    }
}
