//
//  SpendStoreable.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

protocol SpendStoreable {
    func getSpendDay(date: Date) throws -> SpendDay_Data
    func getSpendItems(date: Date) throws -> [SpendItem_Data]
    func getSpendItems(dates: [Date]) throws -> [SpendItem_Data]
    func saveItem(_ item: SpendItem_Data) throws
    func deleteItem(_ item: SpendItem_Data) throws
    func prepStoreForMonth(_ dates: [Date])
    func purgeStore()
}
