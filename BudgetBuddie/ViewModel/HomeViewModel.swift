//
//  HomeViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class HomeViewModel {
    // Instance vars
    let budgetSummaryViewModel: BudgetSummaryViewModel
    let spendViewModel: SpendViewModel
    
    // Constructors
    init(
        budgetSummaryViewModel: BudgetSummaryViewModel,
        spendViewModel: SpendViewModel
    ) {
        self.budgetSummaryViewModel = budgetSummaryViewModel
        self.spendViewModel = spendViewModel
    }
}


// MARK: - Mocks
extension HomeViewModel {
    static func mock() -> HomeViewModel {
        HomeViewModel(
            budgetSummaryViewModel: .mock(),
            spendViewModel: .mock()
        )
    }
}
