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
    let rundownViewModel: BudgetRundownViewModel
    let spendViewModel: SpendViewModel
    
    // Constructors
    init(
        rundownViewModel: BudgetRundownViewModel,
        spendViewModel: SpendViewModel
    ) {
        self.rundownViewModel = rundownViewModel
        self.spendViewModel = spendViewModel
    }
}


// MARK: - Mocks
extension HomeViewModel {
    static func mock() -> HomeViewModel {
        HomeViewModel(
            rundownViewModel: .mock(),
            spendViewModel: .mock()
        )
    }
}
