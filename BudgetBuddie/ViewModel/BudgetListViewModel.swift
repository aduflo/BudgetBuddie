//
//  BudgetListViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct BudgetListViewModel {
    let items: [BudgetListItemViewModel]
}

// MARK: Stubs
extension BudgetListViewModel {
    static func stub() -> Self {
        let items = (0..<25).map {
            BudgetListItemViewModel(value: String($0))
        }
        return Self(items: items)
    }
}
