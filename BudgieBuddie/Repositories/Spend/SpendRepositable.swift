//
//  SpendRepositable.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

protocol SpendRepositable {
    func setup(settingsService: any SettingsServiceable) throws
    /// Get a collection of items for a specific date.
    /// - Returns: An array of `SpendItem`.
    func getItems(date: Date) throws -> [SpendItem]
    /// Get a collection of items for multiple dates.
    /// - Returns: An array of `SpendItem`.
    func getItems(dates: [Date]) throws -> [SpendItem]
    func saveItem(_ item: SpendItem) throws
    func deleteItem(_ item: SpendItem) throws
    func getDay(date: Date) throws -> SpendDay
    func getAllMonths() throws -> [SpendMonth]
    func getMonth(date: Date) throws -> SpendMonth
}
