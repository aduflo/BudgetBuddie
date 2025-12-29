//
//  BudgetTrendViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation
import SwiftUI

@Observable
class BudgetTrendViewModel {
    // Instance vars
    let title: String
    /// Amount in dollars and cents
    let currentSpend: Decimal
    /// Amount in dollars and cents
    let maxSpend: Decimal
    
    private let settingsService: SettingsServiceable
    private let currencyFormatter: CurrencyFormattable
    
    // Constructors
    /// - `currentSpend` should be of dollar and cents value
    /// - `maxSpend` should be of dollar and cents value
    init(
        title: String,
        currentSpend: Decimal,
        maxSpend: Decimal,
        settingsService: SettingsServiceable,
        currencyFormatter: CurrencyFormattable
    ) {
        self.title = title
        self.currentSpend = currentSpend
        self.maxSpend = maxSpend
        self.settingsService = settingsService
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
            spend: currentSpend,
            max: maxSpend
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
        let warningThreshold = Decimal(floatLiteral: settingsService.warningThreshold)
        return switch percentage {
        case 0.0..<warningThreshold: .acceptable
        case warningThreshold..<1.0: .encroaching
        default: .exceeded
        }
    }
}

// MARK: - Mocks
extension BudgetTrendViewModel {
    static func mockDaily() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: Copy.daily,
            currentSpend: 0,
            maxSpend: 0,
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
    
    static func mockMtd() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: Copy.monthToDate,
            currentSpend: 0,
            maxSpend: 0,
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
    
    static func mockMonthly() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: Copy.monthly,
            currentSpend: 0,
            maxSpend: 0,
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
    
    static func mockAcceptable() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: Copy.budgetTrend,
            currentSpend: 40.00,
            maxSpend: 50.00,
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
    
    static func mockEncroaching() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: Copy.budgetTrend,
            currentSpend: 8000.00,
            maxSpend: 9000.00,
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
    
    static func mockExceeded() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: Copy.budgetTrend,
            currentSpend: 9000.01,
            maxSpend: 9000.00,
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
