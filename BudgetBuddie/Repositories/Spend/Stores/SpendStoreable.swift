//
//  SpendStoreable.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

protocol SpendStoreable {
    /// Get all items held by the store.
    /// - Returns: An array of `SpendItem_Data`.
    func getAllItems() throws -> [SpendItem_Data]
    /// Get all items for a specific date.
    /// - Returns: An array of `SpendItem_Data`.
    func getItems(date: Date) throws -> [SpendItem_Data]
    /// Get all items for multiple dates.
    /// - Returns: An array of `SpendItem_Data`.
    func getItems(dates: [Date]) throws -> [SpendItem_Data]
    func saveItem(_ item: SpendItem_Data) throws
    func deleteItem(_ item: SpendItem_Data) throws
    func getDay(date: Date) throws -> SpendDay_Data
    func getAllMonths() throws -> [SpendMonth_Data]
    func getMonth(month: Int, year: Int) throws -> SpendMonth_Data
    func saveMonth(_ month: SpendMonth_Data) throws
    func deleteStagedMonthData() throws
    func stageMonthData(_ date: Date) throws
    
    // TODO: remove after testing
//    func commitMultipleMonths()
//    func purgeAllMonths()
}
