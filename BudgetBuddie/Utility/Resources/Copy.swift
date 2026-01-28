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
    // App Name
    static let budgetBuddieName = "BudgetBuddie"
    static let budgetName = "Budget"
    static let buddieName = "Buddie"
    
    // Title
    static let settingsTitle = "Settings"
    static let newSpendItemTitle = "New Spend Item"
    static let editSpendItemTitle = "Edit Spend Item"
    static let historyTitle = "History"
    static let monthSummaryTitle = "Month Summary"
    
    // Button
    static let historyButton = "History"
    
    // Misc.
    static let spendTrends = "Spend trends"
    static let current = "Current"
    static let max = "Max"
    static let spendItems = "Spend items"
    static let summary = "Summary"
    static let days = "Days"
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
    static let errorSomethingWentWrong = "Error! Something went wrong."
    static let notAvailabile = "N/A"
    static let spend = "Spend"
    static let date = "Date"
    static let allowance = "Allowance"
    static let newest = "Newest"
    static let oldest = "Oldest"
    static let lessSpend = "$"
    static let moreSpend = "$$$$"
    static let noRecordedHistory = "No recorded history."
    static func letsSeeHowWeDidThisMonth(_ month: String) -> String {
        "Let's see how we did in \(month):"
    }
    static let greatJobLetsKeepItUp = "Great job! Let's keep it up."
    static let letsDoBetterThisMonth = "Let's do better this month."
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

extension Copy {
    // MARK: Markdown
    static var onboardingExplanation: LocalizedStringKey {
        """
        Welcome!
        
        **\(budgetBuddieName)** is a simple budgeting app with two primary intents:
        
        1) To provide a bird's-eye view of your monthly expenses
        2) To promote habit building behavior
        
        When using **\(budgetBuddieName)**, you simply log your expenses day-to-day. The logged expenses are attached to whichever day is specified and assist in the compilation of a view (of the ongoing month's expenses).
        
        When a month concludes, you will be shown a summary. Additionally, if you'd like to see how you've tended to your budget over time, you can view that in your history.
        
        Lastly, there are visual cues to suggest how you are doing with your monthly expenses. To learn more about those, see _Settings_ (via the ⚙️).
        
        Enjoy and happy saving! 😃
        """
    }
}
