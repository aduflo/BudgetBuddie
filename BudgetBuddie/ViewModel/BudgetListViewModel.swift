//
//  BudgetListViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct BudgetListViewModel {
    // Instance vars
    let items: [BudgetListItemViewModel]
}

// MARK: - Mocks
extension BudgetListViewModel {
    static func mock() -> Self {
        let items = (0..<25).map {
            BudgetListItemViewModel(value: String($0))
        }
        return Self(items: items)
    }
}
