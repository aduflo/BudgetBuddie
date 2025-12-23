//
//  BudgetViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class BudgetViewModel {
    let rundownViewModel: BudgetRundownViewModel
    let listViewModel: BudgetListViewModel
    var presentSettings: Bool = false
    
    init(rundownViewModel: BudgetRundownViewModel, listViewModel: BudgetListViewModel) {
        self.rundownViewModel = rundownViewModel
        self.listViewModel = listViewModel
    }
}

// MARK: - Mocks
extension BudgetViewModel {
    static func mock() -> BudgetViewModel {
        BudgetViewModel(
            rundownViewModel: BudgetRundownViewModel(
                selectedDate: Date(),
                dailyTrendViewModel: .mockDailyAcceptable(),
                mtdTrendViewModel: .mockMtd(),
                monthlyTrendViewModel: .mockMonthly()
            ),
            listViewModel: .mock()
        )
    }
}
