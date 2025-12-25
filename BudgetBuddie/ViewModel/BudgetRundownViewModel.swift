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
    func reloadData() {
        print("\(String(describing: Self.self))-\(#function)")
    }
    
    var displayDate: String {
        selectedDate.formatted(
            date: .long,
            time: .omitted
        )
    }
    
    func postNotificationSettingsTapped() {
        NotificationCenter.default.post(.SettingsTapped)
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
