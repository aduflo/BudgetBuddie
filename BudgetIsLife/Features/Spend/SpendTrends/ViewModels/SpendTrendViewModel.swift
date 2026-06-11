//
//  SpendTrendViewModel.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation

@Observable
class SpendTrendViewModel {
    // Instance vars
    private let settingsService: SettingsServiceable
    private let currencyFormatter: CurrencyFormatter
    let viewpoint: SpendTrendViewpoint
    let title: String
    let spend: Decimal
    let allowance: Decimal
    let surplus: Decimal
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        currencyFormatter: CurrencyFormatter,
        viewpoint: SpendTrendViewpoint,
        title: String,
        spend: Decimal,
        allowance: Decimal,
        surplus: Decimal
    ) {
        self.settingsService = settingsService
        self.currencyFormatter = currencyFormatter
        self.viewpoint = viewpoint
        self.title = title
        self.spend = spend
        self.allowance = allowance
        self.surplus = surplus
    }
}

// MARK: Public interface
extension SpendTrendViewModel {
    var spendHeadline: String {
        Copy.spend
    }
    
    var allowanceHeadline: String {
        Copy.allowance
    }
    
    var remainingOverspendHeadline: String {
        if (remaining > 0.0) {
            Copy.remaining
        } else {
            Copy.overspend
        }
    }
    
    var surplusHeadline: String {
        Copy.surplus
    }
    
    var displaySpend: String {
        currencyFormatter.stringAmount(spend)
    }
    
    var displayAllowance: String {
        currencyFormatter.stringAmount(allowance)
    }
    
    var displayRemainingOverspend: String {
        currencyFormatter.stringAmount(remaining)
    }
    
    var displaySurplus: String {
        currencyFormatter.stringAmount(surplus)
    }
    
    func evaluateBudget() -> SpendTrendEvaluation {
        let spendPercentage = spend / allowance
        let warningThreshold = Decimal(floatLiteral: settingsService.warningThreshold)
        return switch spendPercentage {
        case 0.0..<warningThreshold: .acceptable
        case warningThreshold..<1.0: .encroaching
        default: .exceeded
        }
    }
    
    var isSurplusAvailable: Bool {
        surplus > 0
    }
}

// MARK: Private interface
private extension SpendTrendViewModel {
    var remaining: Decimal {
        allowance - spend
    }
}

// MARK: - Mocks
extension SpendTrendViewModel {
    static func mockAcceptable(viewpoint: SpendTrendViewpoint) -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: {
                let settingsService = MockSettingsService()
                settingsService.setWarningThreshold(100.0)
                return settingsService
            }(),
            currencyFormatter: CurrencyFormatter(),
            viewpoint: viewpoint,
            title: Copy.budgetTrend,
            spend: 40.00,
            allowance: 50.00,
            surplus: 10.00
        )
    }
    
    static func mockEncroaching(viewpoint: SpendTrendViewpoint) -> SpendTrendViewModel {
        return SpendTrendViewModel(
            settingsService: {
                let settingsService = MockSettingsService()
                settingsService.setWarningThreshold(0.0)
                return settingsService
            }(),
            currencyFormatter: CurrencyFormatter(),
            viewpoint: viewpoint,
            title: Copy.budgetTrend,
            spend: 80.00,
            allowance: 100.00,
            surplus: 20.00
        )
    }
    
    static func mockExceeded(viewpoint: SpendTrendViewpoint) -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter(),
            viewpoint: viewpoint,
            title: Copy.budgetTrend,
            spend: 9000.01,
            allowance: 9000.00,
            surplus: 0.00
        )
    }
}
