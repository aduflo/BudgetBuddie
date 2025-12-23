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

// MARK: Stubs
extension BudgetViewModel {
    static func stub() -> Self {
        Self(
            rundownViewModel: .stub(),
            listViewModel: .stub()
        )
    }
}
