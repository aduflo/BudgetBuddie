//
//  OnDiskSpendStore.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class OnDiskSpendStore: SpendStoreable {    
    // SpendStoreable
    func getSpendDay(date: Date) throws -> SpendDay {
        // TODO: implement
        return SpendDay(id: UUID(), date: Date(), items: [])
    }
    
    func getSpendItems(date: Date) throws -> [SpendItem] {
        // TODO: implement
        return []
    }
    
    func getAllSpendItems(date: Date) throws -> [SpendItem] {
        // TODO: implement
        return []
    }
    
    func saveItem(_ item: SpendItem) throws {
        // TODO: implement
    }
    
    func deleteItem(_ item: SpendItem) throws {
        // TODO: implement
    }
    
    func prepStoreForMonth(_ dates: [Date]) {
        // TODO: implement
    }
    
    func purgeStore() {
        // TODO: implement
    }
}
