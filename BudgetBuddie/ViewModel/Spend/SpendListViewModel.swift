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
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable
    
    private(set) var items: [SpendListItemViewModel]
    
    var onSpendItemTapped: (SpendItem) -> () = { _ in }
    
    init(
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable,
        items: [SpendListItemViewModel] = []
    ) {
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        self.items = items
    }
}

// MARK: Public interface
extension SpendListViewModel {
    func spendItemTapped(_ spendItem: SpendItem) {
        onSpendItemTapped(spendItem)
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
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: currencyFormatter,
            items: items
        )
    }
}
