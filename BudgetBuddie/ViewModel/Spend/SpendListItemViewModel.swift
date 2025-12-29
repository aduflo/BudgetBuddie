//
//  SpendListItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct SpendListItemViewModel: Identifiable {
    // Instance vars
    let spendItem: SpendItem
    
    private let currencyFormatter: CurrencyFormattable
    
    // Identifiable
    let id = UUID()
}

// MARK: Public interface
extension SpendListItemViewModel {
    var displayAmount: String {
        "Amount: \(currencyFormatter.stringAmount(spendItem.amount))"
    }
    
    var displayNote: String {
        "Note: \(spendItem.note ?? "N/A")"
    }
}

// MARK: - Mocks
extension SpendListItemViewModel {
    static func mock() -> Self {
        Self(
            spendItem: SpendItem(
                id: UUID(),
                amount: 13.37,
                note: (([1, 2].randomElement() ?? 0) % 2 == 0) ? "yar" : nil
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
