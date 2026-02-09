//
//  OnDiskSpendStore.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation
import SwiftData

class SwiftDataSpendStore: SpendStoreable {
    // Instance vars
    private let container: ModelContainer? = {
        try? ModelContainer(
            for: SpendMonth_SwiftData.self,
            SpendDay_SwiftData.self,
            SpendItem_SwiftData.self,
            configurations: ModelConfiguration()
        )
    }()
    private var context: ModelContext? {
        container?.mainContext
    }
    
    // SpendStoreable
    func getAllItems() throws -> [SpendItem_Data] {
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
            // get day associated with item
            let day_swiftData = try getDay_swiftData(id: item.dayId)
            
            // transform into SwiftData model
            let item_swiftData = SpendItemMapper.toSwiftDataObject(item)
            
            // save item to items
            var items_swiftData = day_swiftData.items
            var oldItem_swiftData: SpendItem_SwiftData? // need to hold reference for old model object
            if let matchingIdx = items_swiftData.firstIndex(
                where: { $0.id == item_swiftData.id }
            ) {
                oldItem_swiftData = items_swiftData.remove(at: matchingIdx)
                items_swiftData.insert(item_swiftData, at: matchingIdx)
            } else {
                items_swiftData.append(item_swiftData)
            }
            
            // update context
            try context?.transaction {
                if let oldItem_swiftData {
                    // delete old model object to prevent .id collision
                    // given items are bound to .id
                    context?.delete(oldItem_swiftData)
                }
                day_swiftData.setItems(items_swiftData)
            }
        } catch {
            throw SpendStoreError.unableToSaveItem
        }
    }
    
    func deleteItem(_ item: SpendItem_Data) throws {
        do {
            // get swiftData reference for item
            let item_swiftData = try getItem_swiftData(id: item.id)
            
            // update context
            try context?.transaction {
                context?.delete(item_swiftData)
            }
        } catch {
            throw SpendStoreError.unableToDeleteItem
        }
    }
    
    func getDay(date: Date) throws -> SpendDay_Data {
        let key = SpendDayKey(date).value
        let descriptor = FetchDescriptor<SpendDay_SwiftData>(
            predicate: #Predicate { $0.key == key }
        )
        let days = try context?.fetch(descriptor)
        
        guard let firstDay = days?.first else {
            throw SpendStoreError.dayNotFound
        }
        
        return SpendDayMapper.toDataObject(firstDay)
    }
    
    func getDay(id: UUID) throws -> SpendDay_Data {
        let days = try context?.fetch(
            FetchDescriptor<SpendDay_SwiftData>(
                predicate: #Predicate { $0.id == id }
            )
        )
        
        guard let firstDay = days?.first else {
            throw SpendStoreError.dayNotFound
        }
        
        return SpendDayMapper.toDataObject(firstDay)
    }
    
    func getAllMonths() throws -> [SpendMonth_Data] {
        do {
            let fetchDescriptor = FetchDescriptor<SpendMonth_SwiftData>()
            guard let months_swiftData = try context?.fetch(fetchDescriptor) else {
                throw SpendStoreError.monthsNotFound
            }
            let months_data = months_swiftData.map {
                SpendMonthMapper.toDataObject($0)
            }
            return months_data
        } catch {
            throw SpendStoreError.monthsNotFound
        }
    }
    
    func getMonth(date: Date) throws -> SpendMonth_Data {
        let calendar = Calendar.current
        let month = calendar.monthInDate(date)
        let year = calendar.yearInDate(date)
        do {
            let predicate: Predicate<SpendMonth_SwiftData> = #Predicate {
                $0.month == month && $0.year == year
            }
            let fetchDescriptor = FetchDescriptor(
                predicate: predicate
            )
            guard let month_swiftData = try context?.fetch(fetchDescriptor).first else {
                throw SpendStoreError.monthNotFound
            }
            
            let month_data = SpendMonthMapper.toDataObject(month_swiftData)
            return month_data
        } catch {
            throw SpendStoreError.monthNotFound
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
    
    func deleteStagedMonthData() throws {
        do {
            // deleting all instances of SpendDay_SwiftData within context
            // due to relationship (delete rule: cascading) with SpendItem_SwiftData
            // all associated [SpendItem_SwiftData] instances will also be deleted
            try context?.transaction {
                try context?.delete(
                    model: SpendDay_SwiftData.self
                )
            }
        } catch {
            throw SpendStoreError.unableToDeleteStagedMonthData
        }
    }
    
    func stageMonthData(_ date: Date) throws {
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
            throw SpendStoreError.unableToStageMonth
        }
    }
}

// MARK: Private interface
private extension SwiftDataSpendStore {
    func getItem_swiftData(id: UUID) throws -> SpendItem_SwiftData {
        let items = try context?.fetch(
            FetchDescriptor<SpendItem_SwiftData>(
                predicate: #Predicate { $0.id == id }
            )
        )
        
        guard let item_swiftData = items?.first else {
            throw SpendStoreError.itemNotFound
        }
        
        return item_swiftData
    }
    
    func getDay_swiftData(id: UUID) throws -> SpendDay_SwiftData {
        let days = try context?.fetch(
            FetchDescriptor<SpendDay_SwiftData>(
                predicate: #Predicate { $0.id == id }
            )
        )
        
        guard let day_swiftData = days?.first else {
            throw SpendStoreError.dayNotFound
        }
        
        return day_swiftData
    }
}
