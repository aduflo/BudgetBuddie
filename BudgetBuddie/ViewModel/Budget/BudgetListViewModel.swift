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
    let currencyFormatter: CurrencyFormattable
    
    init(
        items: [BudgetListItemViewModel] = [],
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
    ) {
        self.items = items
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: - Mocks
extension BudgetListViewModel {
    static func mock() -> BudgetListViewModel {
        let currencyFormatter = CurrencyFormatter()
        let items = (0..<25).map { _ in
            BudgetListItemViewModel.mock()
        }
        return BudgetListViewModel(
            items: items,
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: currencyFormatter
        )
    }
}
