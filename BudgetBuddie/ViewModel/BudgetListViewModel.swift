//
//  BudgetListViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class BudgetListViewModel {
    // Instance vars
    let items: [BudgetListItemViewModel]
    
    init(
        items: [BudgetListItemViewModel]
    ) {
        self.items = items
    }
}

// MARK: - Mocks
extension BudgetListViewModel {
    static func mock() -> BudgetListViewModel {
        let items = (0..<25).map {
            BudgetListItemViewModel(value: String($0))
        }
        return BudgetListViewModel(items: items)
    }
}
