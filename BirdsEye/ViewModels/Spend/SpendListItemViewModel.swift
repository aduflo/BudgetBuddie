//
//  SpendListItemViewModel.swift
//  BirdsEye
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct SpendListItemViewModel: Identifiable {
    // Instance vars
    private let currencyFormatter: CurrencyFormatter
    let spendItem: SpendItem
    
    // Identifiable
    let id = UUID()
    
    // Constructors
    init(
        currencyFormatter: CurrencyFormatter,
        spendItem: SpendItem
    ) {
        self.currencyFormatter = currencyFormatter
        self.spendItem = spendItem
    }
}

// MARK: Public interface
extension SpendListItemViewModel {
    var displayAmount: String {
        currencyFormatter.stringAmount(spendItem.amount)
    }
    
    var displayNote: String {
        spendItem.note ?? Copy.notAvailabile
    }
}

// MARK: - Mocks
extension SpendListItemViewModel {
    static func mock() -> Self {
        Self(
            currencyFormatter: CurrencyFormatter(),
            spendItem: SpendItem(
                amount: 13.37,
                note: (([1, 2].randomElement() ?? 0) % 2 == 0) ? "yar" : nil,
                date: Date()
            )
        )
    }
}
