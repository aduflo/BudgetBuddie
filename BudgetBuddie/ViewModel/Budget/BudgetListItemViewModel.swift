//
//  BudgetListItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct BudgetListItemViewModel: Identifiable {
    // Instance vars
    let spendItem: SpendItem
    
    let currencyFormatter: CurrencyFormattable
    
    // Identifiable
    let id = UUID()
}

// MARK: Public interface
extension BudgetListItemViewModel {
    var displayValue: String {
        currencyFormatter.stringAmount(spendItem.amount)
    }
}

// MARK: - Mocks
extension BudgetListItemViewModel {
    static func mock() -> Self {
        Self(
            spendItem: SpendItem(
                id: UUID(),
                amount: 13.37,
                note: (([1, 2].randomElement() ?? 0) % 2 == 0) ? "yar" : nil,
                dayId: UUID()
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
