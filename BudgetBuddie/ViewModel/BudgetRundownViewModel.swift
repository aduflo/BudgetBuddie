//
//  BudgetRundownViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct BudgetRundownViewModel {
    // Instance vars
    let dailyTrendViewModel: BudgetTrendViewModel
    let mtdTrendViewModel: BudgetTrendViewModel
    let monthTrendViewModel: BudgetTrendViewModel
}

// MARK: Public interface
extension BudgetRundownViewModel {
    var displayDate: String {
        "Dec. 12th, 2025"
    }
}

// MARK: Mocks
extension BudgetRundownViewModel {
    static func mock() -> Self {
        Self(
            dailyTrendViewModel: BudgetTrendViewModel(
                title: "Daily",
                currentSpend: 4000,
                maxSpend: 5000,
                tolerance: .mock(),
                currencyFormatter: USDCurrencyFormatter.shared
            ),
            mtdTrendViewModel: BudgetTrendViewModel(
                title: "Month-To-Date (MTD)",
                currentSpend: 20000,
                maxSpend: 25000,
                tolerance: .mock(),
                currencyFormatter: USDCurrencyFormatter.shared
            ),
            monthTrendViewModel: BudgetTrendViewModel(
                title: "Monthly",
                currentSpend: 20000,
                maxSpend: 150000,
                tolerance: .mock(),
                currencyFormatter: USDCurrencyFormatter.shared
            )
        )
    }
}
