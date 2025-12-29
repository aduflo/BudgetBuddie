//
//  Copy.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/29/25.
//

import Foundation

enum Copy {
    static let appName = "BudgetBuddie"
    static let spendingTrends = "Spending trends"
    static let current = "Current"
    static let max = "Max"
    static let spendItems = "Spend items"
    static let summary = "Summary"
    static let days = "Days"
    static let settings = "Settings"
    static let monthlyAllowance = "Monthly allowance"
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
    static func amount(_ value: String) -> String {
        "Amount: \(value)"
    }
    static func note(_ value: String) -> String {
        "Note: \(value)"
    }
}
