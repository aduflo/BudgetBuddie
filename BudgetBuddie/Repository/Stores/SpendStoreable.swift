//
//  SpendStoreable.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

protocol SpendStoreable {
    func getSpendDay(date: Date) throws -> SpendDay
    func getSpendItems(date: Date) throws -> [SpendItem]
    func getAllSpendItems(date: Date) throws -> [SpendItem]
    func saveItem(_ item: SpendItem) throws
    func deleteItem(_ item: SpendItem) throws
    func prepStoreForMonth(_ dates: [Date])
    func purgeStore()
}
