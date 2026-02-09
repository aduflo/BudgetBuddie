//
//  SpendTrendViewModel.swift
//  BudgieBuddie
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
    let remaining: Decimal
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        currencyFormatter: CurrencyFormatter,
        viewpoint: SpendTrendViewpoint,
        title: String,
        spend: Decimal,
        allowance: Decimal,
        remaining: Decimal
    ) {
        self.settingsService = settingsService
        self.currencyFormatter = currencyFormatter
        self.viewpoint = viewpoint
        self.title = title
        self.spend = spend
        self.allowance = allowance
        self.remaining = max(remaining, 0.0)
    }
}

// MARK: Public interface
extension SpendTrendViewModel {
    var displaySpend: String {
        currencyFormatter.stringAmount(spend)
    }
    
    var displayAllowance: String {
        currencyFormatter.stringAmount(allowance)
    }
    
    var displayRemaining: String {
        currencyFormatter.stringAmount(remaining)
    }
    
    var isRemainingAvailable: Bool {
        (remaining > 0.0)
    }
    
    func evaluateBudget() -> BudgetEvaluation {
        let percentage = spend / allowance
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
            remaining: 10.00
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
            remaining: 20.00
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
            remaining: 0.0
        )
    }
}
