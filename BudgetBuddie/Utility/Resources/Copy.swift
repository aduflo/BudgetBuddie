//
//  Copy.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/29/25.
//

import Foundation
import SwiftUI

enum Copy {}

extension Copy {
    // MARK: String
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
    static let amountTitleKey = "How much did you spend?"
    static let note = "Note"
    static let noteTitleKey = "What did you spend money on?"
    static let deleteAlertTitle = "Are you sure you want to delete this spend item?"
    static let cancel = "Cancel"
    static let delete = "Delete"
    static let goodJobSaving = "Good job saving today!"
    static let errorPleaseTryAgain = "Error! Please try again."
    static let errorFetchingItems = "Error! Could not fetch spend items."
}

extension Copy {
    // MARK: AttributedString
    static let warningThresholdFootnote: AttributedString = {
        let current = Copy.current
        let spendTrends = Copy.spendTrends
        let green = "green"
        let orange = "orange"
        var attributedString = AttributedString("The warning threshold determines when to warn that you've exceeded your comfortable spending allotment. When you've exceeded your comfortable spending allotment, the \(current) amounts under \(spendTrends) will change from \(green) to \(orange).")
        
        if let currentRange = attributedString.range(of: current) {
            attributedString[currentRange].inlinePresentationIntent = .stronglyEmphasized
        }
        if let spendingTrendsRange = attributedString.range(of: spendTrends) {
            attributedString[spendingTrendsRange].inlinePresentationIntent = .stronglyEmphasized
        }
        if let greenRange = attributedString.range(of: green) {
            attributedString[greenRange].foregroundColor = .green
        }
        if let orangeRange = attributedString.range(of: orange) {
            attributedString[orangeRange].foregroundColor = .orange
        }
        
        return attributedString
    }()
    static func required(_ value: String) -> AttributedString {
        let asterisk = "*"
        var attributedString = AttributedString("\(value) \(asterisk)")
        if let asteriskRange = attributedString.range(of: asterisk) {
            attributedString[asteriskRange].inlinePresentationIntent = .stronglyEmphasized
            attributedString[asteriskRange].foregroundColor = .red
        }
        return attributedString
    }
    static let requiredFieldWarningAmount: AttributedString = {
        let attributedString = AttributedString(
            "Amount is a required field",
            attributes: {
                var attributes = AttributeContainer()
                attributes[AttributeScopes.SwiftUIAttributes.ForegroundColorAttribute.self] = .red
                return attributes
            }()
        )
        return attributedString
    }()
}
