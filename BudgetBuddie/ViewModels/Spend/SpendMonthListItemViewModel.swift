//
//  SpendMonthListItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import Foundation
import SwiftUI

struct SpendMonthListItemViewModel: Identifiable {
    // Instance vars
    private let currencyFormatter: CurrencyFormatter
    let spendMonth: SpendMonth
    
    // Identifiable
    let id = UUID()
    
    // Constructors
    init(
        currencyFormatter: CurrencyFormatter,
        spendMonth: SpendMonth
    ) {
        self.currencyFormatter = currencyFormatter
        self.spendMonth = spendMonth
    }
}

// MARK: Public interface
extension SpendMonthListItemViewModel {
    var displayDate: String {
        "\(spendMonth.year)/\(spendMonth.month)"
    }
    
    var backgroundColor: Color {
        if spendMonth.spend > spendMonth.allowance {
            .red
        } else {
            .green
        }
    }
    
    var displaySpend: String {
        currencyFormatter.stringAmount(spendMonth.spend)
    }
    
    var displayAllowance: String {
        currencyFormatter.stringAmount(spendMonth.allowance)
    }
}

// MARK: - Mocks
extension SpendMonthListItemViewModel {
    static func mock() -> Self {
        Self(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
    }
}
