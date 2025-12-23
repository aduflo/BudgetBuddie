//
//  BudgetRundownViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct BudgetRundownViewModel {
    // Instance vars
    let selectedDate: Date
    let dailyTrendViewModel: BudgetTrendViewModel
    let mtdTrendViewModel: BudgetTrendViewModel
    let monthlyTrendViewModel: BudgetTrendViewModel
    let onSettingsTapped: () -> ()
}

// MARK: Public interface
extension BudgetRundownViewModel {
    var displayDate: String {
        selectedDate.formatted(
            date: .long,
            time: .omitted
        )
    }
}

// MARK: Mocks
extension BudgetRundownViewModel {
    static func mock() -> Self {
        Self(
            selectedDate: Date(),
            dailyTrendViewModel: BudgetTrendViewModel(
                title: "Daily",
                currentSpend: 4000,
                maxSpend: 5000,
                tolerance: .mock(),
                currencyFormatter: USDCurrencyFormatter.shared
            ),
            mtdTrendViewModel: BudgetTrendViewModel(
                title: "Month-To-Date (MTD)",
                currentSpend: 23000,
                maxSpend: 25000,
                tolerance: .mock(),
                currencyFormatter: USDCurrencyFormatter.shared
            ),
            monthlyTrendViewModel: BudgetTrendViewModel(
                title: "Monthly",
                currentSpend: 23000,
                maxSpend: 150000,
                tolerance: .mock(),
                currencyFormatter: USDCurrencyFormatter.shared
            ),
            onSettingsTapped: { print("Settings tapped") }
        )
    }
}
