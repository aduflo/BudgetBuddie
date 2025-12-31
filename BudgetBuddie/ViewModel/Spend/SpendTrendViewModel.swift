//
//  SpendTrendViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation
import SwiftUI

@Observable
class SpendTrendViewModel {
    // Instance vars
    private let settingsService: SettingsServiceable
    private let currencyFormatter: CurrencyFormattable
    
    let title: String
    /// Amount in dollars and cents
    let currentSpend: Decimal
    /// Amount in dollars and cents
    let maxSpend: Decimal
    
    // Constructors
    /// - `currentSpend` should be of dollar and cents value
    /// - `maxSpend` should be of dollar and cents value
    init(
        settingsService: SettingsServiceable,
        currencyFormatter: CurrencyFormattable,
        title: String,
        currentSpend: Decimal,
        maxSpend: Decimal
    ) {
        self.title = title
        self.currentSpend = currentSpend
        self.maxSpend = maxSpend
        self.settingsService = settingsService
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension SpendTrendViewModel {
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
private extension SpendTrendViewModel {
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
extension SpendTrendViewModel {
    static func mockDaily() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.daily,
            currentSpend: 13.37,
            maxSpend: 1337
        )
    }
    
    static func mockMtd() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.monthToDate,
            currentSpend: 13.37,
            maxSpend: 7331.00
        )
    }
    
    static func mockMonthly() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.monthly,
            currentSpend: 9001.00,
            maxSpend: 9000.00
        )
    }
    
    static func mockAcceptable() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.budgetTrend,
            currentSpend: 40.00,
            maxSpend: 50.00
        )
    }
    
    static func mockEncroaching() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.budgetTrend,
            currentSpend: 8000.00,
            maxSpend: 9000.00
        )
    }
    
    static func mockExceeded() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.budgetTrend,
            currentSpend: 9000.01,
            maxSpend: 9000.00
        )
    }
}
