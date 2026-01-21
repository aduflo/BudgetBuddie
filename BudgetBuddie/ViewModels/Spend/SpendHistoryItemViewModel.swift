//
//  SpendHistoryItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import Foundation
import SwiftUI

struct SpendHistoryItemViewModel: Identifiable {
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
extension SpendHistoryItemViewModel {
    var displayDate: String {
        let month = if spendMonth.month < 10 {
            "0\(spendMonth.month)"
        } else {
            String(spendMonth.month)
        }
        let year = String(spendMonth.year - 2000)
        // TODO: use actual date once refactor occurs, and leverage the date format used in the header of SpendListView
        return "\(month)/\(year)"
    }
    
    var displaySpend: String {
        currencyFormatter.stringAmount(spendMonth.spend)
    }
    
    var displayAllowance: String {
        currencyFormatter.stringAmount(spendMonth.allowance)
    }
    
    var displayDifference: String {
        let difference = spendMonth.allowance - spendMonth.spend
        let stringDifference = currencyFormatter.stringAmount(difference)
        return if difference < 0 {
            "-\(stringDifference)"
        } else {
            "+\(stringDifference)"
        }
    }
    
    var isSpendWithinBudget: Bool {
        spendMonth.spend <= spendMonth.allowance
    }
}

// MARK: - Mocks
extension SpendHistoryItemViewModel {
    static func mock() -> Self {
        Self(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
    }
}
