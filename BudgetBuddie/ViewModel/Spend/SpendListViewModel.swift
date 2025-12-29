//
//  SpendListViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class SpendListViewModel {
    // Instance vars
    private(set) var items: [SpendListItemViewModel]
    
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable
    
    init(
        items: [SpendListItemViewModel] = [],
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
    ) {
        self.items = items
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: - Mocks
extension SpendListViewModel {
    static func mock() -> SpendListViewModel {
        let currencyFormatter = CurrencyFormatter()
        let items = (0..<25).map { _ in
            SpendListItemViewModel.mock()
        }
        return SpendListViewModel(
            items: items,
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: currencyFormatter
        )
    }
}
