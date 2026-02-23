//
//  Copy.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/29/25.
//

import Foundation
import SwiftUI

enum Copy {}

extension Copy {
    // MARK: String
    // App Name
    static let appName = "BudgetIsLife"
    static let appNameAcronym = "BIL"
    
    // Title
    static let settingsTitle = "Settings"
    static let newSpendItemTitle = "New Spend Item"
    static let editSpendItemTitle = "Edit Spend Item"
    static let monthlyHistoryTitle = "Monthly History"
    static let monthSummaryTitle = "Month Summary"
    
    // Button
    static let monthlyHistoryButton = "Monthly History"
    
    // Misc.
    static let spendTrends = "Spend trends"
    static let spendTrendsViewpoint = "Spend trends viewpoint"
    static let defaultSpendTrendsViewpoint = "Default spend trends viewpoint"
    static let spend = "Spend"
    static let allowance = "Allowance"
    static let remaining = "Remaining"
    static let overspend = "Overspend"
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
    static let noNoteProvided = "No note provided"
    static let deleteAlertTitle = "Are you sure you want to delete this spend item?"
    static let cancel = "Cancel"
    static let delete = "Delete"
    static let errorPleaseTryAgain = "Error! Please try again."
    static let errorSomethingWentWrong = "Error! Something went wrong."
    static let notAvailable = "N/A"
    static let date = "Date"
    static let newest = "Newest"
    static let oldest = "Oldest"
    static let lessSpend = "$"
    static let moreSpend = "$$$$"
    static let emptySpendList = "Good job saving!"
    static let emptyMonthlyHistory = "Once your first month concludes, it will show up here (along with all subsequent months)."
    static func letsSeeHowWeDidThisMonth(_ month: String) -> String {
        "Let's see how we did in \(month):"
    }
    static let greatJobLetsKeepItUp = "Great job! Let's keep it up."
    static let letsDoBetterThisMonth = "Let's do better this month."
}

extension Copy {
    // MARK: AttributedString
    static let warningThresholdFootnote: AttributedString = {
        let warningThreshold = Copy.warningThreshold
        let spendTrends = Copy.spendTrends
        let green = "green"
        let orange = "orange"
        var attributedString = AttributedString(
            """
            The \(warningThreshold) determines when to share you've exceeded your comfortable spending allotment.
            
            This will be reflected by changing the color of the amounts shown under \(spendTrends) from \(green) to \(orange).
            """
        )
        
        if let currentRange = attributedString.range(of: warningThreshold) {
            attributedString[currentRange].inlinePresentationIntent = .stronglyEmphasized
        }
        if let currentRange = attributedString.range(of: spendTrends) {
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
    static let onboardingDescription: LocalizedStringKey = {
        """
        Welcome!
        
        **\(Copy.appName)** is a simple budgeting app with two primary intents:
        
        1) To provide a bird's-eye view of your monthly expenses and savings
        2) To promote habit building budgeting behavior
        
        When using **\(Copy.appName)**, you simply log your expenses day-to-day. The logged expenses are attached to whichever day is selected and assist in the compilation of your _\(Copy.spendTrends)_.
        
        When a month concludes, you will be shown a _\(Copy.monthSummaryTitle)_. Additionally, if you'd like to see how you've tended to your budget over time, you can view that in your _\(Copy.monthlyHistoryTitle)_.
        
        Lastly, there are visual cues to suggest how you are doing with your monthly expenses. To learn more about those, see _\(Copy.settingsTitle)_.
        
        Enjoy and happy saving!
        """
    }()
    static let defaultSpendTrendsViewpointFootnote: LocalizedStringKey = {
        """
        The **\(Copy.spendTrendsViewpoint)** dictates the type of information shown in **\(Copy.spendTrends)**.
        
        This selection will be considered your default viewpoint. If you would like to view other viewpoints (while viewing your **\(Copy.spendTrends)**), tap the button indicating the ability to cycle through viewpoints.
        """
    }()
    static let monthlyAllowanceFootnote: LocalizedStringKey = {
        """
        The **\(Copy.monthlyAllowance)** represents what you can spend monthly.
        
        This number influences all calculations used for the amounts shown in your **\(Copy.spendTrends)**.
        """
    }()
}
