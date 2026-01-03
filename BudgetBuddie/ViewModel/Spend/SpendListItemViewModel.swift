//
//  SpendListItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct SpendListItemViewModel: Identifiable {
    // Instance vars
    private let currencyFormatter: CurrencyFormattable
    
    let spendItem: SpendItem
    
    // Identifiable
    let id = UUID()
}

// MARK: Public interface
extension SpendListItemViewModel {
    var displayAmount: String {
        Copy.amount(currencyFormatter.stringAmount(spendItem.amount))
    }
    
    var displayDescription: String {
        Copy.description(spendItem.description ?? "N/A")
    }
}

// MARK: - Mocks
extension SpendListItemViewModel {
    static func mock() -> Self {
        Self(
            currencyFormatter: CurrencyFormatter(),
            spendItem: SpendItem(
                id: UUID(),
                amount: 13.37,
                description: (([1, 2].randomElement() ?? 0) % 2 == 0) ? "yar" : nil,
                date: Date()
            )
        )
    }
}
