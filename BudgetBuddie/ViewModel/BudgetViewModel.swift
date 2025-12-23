//
//  BudgetViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct BudgetViewModel {
    let rundownViewModel: BudgetRundownViewModel
    let listViewModel: BudgetListViewModel
}

// MARK: Mocks
extension BudgetViewModel {
    static func mock() -> Self {
        Self(
            rundownViewModel: .mock(),
            listViewModel: .mock()
        )
    }
}
