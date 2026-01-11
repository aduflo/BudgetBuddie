//
//  SpendRepositable.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

protocol SpendRepositable {
    func setup()
    func getSpendDay(date: Date) throws -> SpendDay
    func getSpendItems(date: Date) throws -> [SpendItem]
    func getSpendItems(dates: [Date]) throws -> [SpendItem]
    func saveItem(_ item: SpendItem) throws
    func deleteItem(_ item: SpendItem) throws
}
