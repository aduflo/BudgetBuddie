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
    private(set) var items: [BudgetListItemViewModel]
    let spendRepository: SpendRepository
    
    init(
        items: [BudgetListItemViewModel] = [],
        spendRepository: SpendRepository
    ) {
        self.items = items
        self.spendRepository = spendRepository
    }
}

// MARK: - Mocks
extension BudgetListViewModel {
    static func mock() -> BudgetListViewModel {
        let items = (0..<25).map {
            BudgetListItemViewModel(value: String($0))
        }
        return BudgetListViewModel(
            items: items,
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            )
        )
    }
}
