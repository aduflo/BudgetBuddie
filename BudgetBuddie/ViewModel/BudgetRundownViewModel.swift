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

// MARK: - Mocks
extension BudgetRundownViewModel {
    static func mock() -> Self {
        Self(
            selectedDate: Date(),
            dailyTrendViewModel: .mockDailyAcceptable(),
            mtdTrendViewModel: .mockMtd(),
            monthlyTrendViewModel: .mockMonthly()
        )
    }
}
