//
//  BudgetTrendViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation
import SwiftUI

struct BudgetTrendViewModel {
    // Instance vars
    let title: String
    let currentSpend: UInt // amount in cents
    let maxSpend: UInt // amount in cents
    let settingsRepo: SettingsRepoing
    let currencyFormatter: CurrencyFormatting
    
    init(
        title: String,
        currentSpend: UInt,
        maxSpend: UInt,
        settingsRepo: SettingsRepoing,
        currencyFormatter: CurrencyFormatting = CurrencyFormatter.shared
    ) {
        self.title = title
        self.currentSpend = currentSpend
        self.maxSpend = maxSpend
        self.settingsRepo = settingsRepo
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension BudgetTrendViewModel {
    var displayCurrentSpend: String {
        return currencyFormatter.stringAmount(currentSpend)
    }
    
    var displayMaxSpend: String {
        return currencyFormatter.stringAmount(maxSpend)
    }
    
    var dailySpendColor: Color {
        return switch evaluateBudget(
            spend: Decimal(currentSpend),
            max: Decimal(maxSpend)
        ) {
        case .acceptable: .green
        case .encroaching: .orange
        case .exceeded: .red
        }
    }
}

// MARK: Private interface
private extension BudgetTrendViewModel {
    func evaluateBudget(spend: Decimal, max: Decimal) -> BudgetEvaluation {
        let percentage = spend / max
        let toleranceThreshold = Decimal(floatLiteral: settingsRepo.toleranceThreshold)
        return switch percentage {
        case 0.0..<toleranceThreshold: .acceptable
        case toleranceThreshold..<1.0: .encroaching
        default: .exceeded
        }
    }
}

// MARK: - Mocks
extension BudgetTrendViewModel {
    static func mockDailyAcceptable() -> Self {
        Self(
            title: "Daily",
            currentSpend: 4000,
            maxSpend: 5000,
            settingsRepo: MockSettingsRepo()
        )
    }
    
    static func mockDailyEncroaching() -> Self {
        Self(
            title: "Daily",
            currentSpend: 800000,
            maxSpend: 900000,
            settingsRepo: MockSettingsRepo()
        )
    }
    
    static func mockDailyExceeded() -> Self {
        Self(
            title: "Daily",
            currentSpend: 900001,
            maxSpend: 900000,
            settingsRepo: MockSettingsRepo()
        )
    }
    
    static func mockMtd() -> Self {
        Self(
            title: "Month-To-Date (MTD)",
            currentSpend: 23000,
            maxSpend: 25000,
            settingsRepo: MockSettingsRepo()
        )
    }
    
    static func mockMonthly() -> Self {
        Self(
            title: "Monthly",
            currentSpend: 23000,
            maxSpend: 150000,
            settingsRepo: MockSettingsRepo()
        )
    }
}
