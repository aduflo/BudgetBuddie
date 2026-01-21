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
            // due to [the aforementioned] relationship with SpendItem_SwiftData, all [SpendItem_SwiftData] instances
            // will also be deleted given presence of relational delete rule: cascading
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
    
    // TODO: remove after testing
    func commitMultipleMonths() {
        do {
            var date = Date()
            let calendar = Calendar.current
            var dates: [Date] = []
            var idx = 0
            while idx < 100 {
                date = calendar.date(
                    byAdding: .day,
                    value: -3,
                    to: date
                ) ?? Date()
                dates.append(date)
                idx += 1
            }
            try context?.transaction {
                for date in dates {
                    context?.insert(
                        SpendMonth_SwiftData(
                            id: UUID(),
                            date: date,
                            month: calendar.monthInDate(date),
                            year: calendar.yearInDate(date),
                            spend: Decimal(floatLiteral: .random(in: (0.0..<2000.00))),
                            allowance: 1337.00
                        )
                    )
                }
                print("\(#function) success")
            }
        } catch {
            print("\(#function) error: \(error)")
        }
    }
    
    func purgeAllMonths() {
        do {
            try context?.transaction {
                try context?.delete(
                    model: SpendMonth_SwiftData.self
                )
                print("\(#function) success")
            }
        } catch {
            print("\(#function) error: \(error)")
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
        let descriptor = FetchDescriptor(
            predicate: predicate
        )
        let spendDays = try context?.fetch(descriptor)
        
        guard let firstDay = spendDays?.first else {
            throw SpendStoreError.dayNotFound
        }
        
        return firstDay
    }
}
