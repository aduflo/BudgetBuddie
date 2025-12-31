//
//  Copy.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/29/25.
//

import Foundation

enum Copy {
    static let appName = "BudgetBuddie"
    static let spendTrends = "Spend trends"
    static let current = "Current"
    static let max = "Max"
    static let spendItems = "Spend items"
    static let newSpendItem = "New spend item"
    static let editSpendItem = "Edit spend item"
    static let summary = "Summary"
    static let days = "Days"
    static let settings = "Settings"
    static let monthlyAllowance = "Monthly allowance"
    static let monthlyAllowanceTitleKey = "How much can you spend monthly?"
    static func warningThreshold(_ value: String) -> String {
        "Warning threshold: \(value)"
    }
    static let warningThreshold = "Warning threshold"
    static let zeroPercent = "0%"
    static let oneHundredPercent = "100%"
    static let daily = "Daily"
    static let monthToDate = "Month-to-date (MTD)"
    static let monthly = "Monthly"
    static let budgetTrend = "Budget trend"
    static let amount = "Amount"
    static func amount(_ value: String) -> String {
        "Amount: \(value)"
    }
    static let amountTitleKey = "How much did you spend?"
    static let description = "Description"
    static func description(_ value: String) -> String {
        "Description: \(value)"
    }
    static let descriptionTitleKey = "What did you spend money on?"
}
