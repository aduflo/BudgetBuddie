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
    func getItems() throws -> [SpendItem_Data]
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
    func getPreviousMonth() throws -> SpendMonth_Data
    func saveMonth(_ month: SpendMonth_Data) throws
    func prepForMonth(_ date: Date) throws
    func deletePreviousMonthData() throws
}
