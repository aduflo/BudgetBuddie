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
        spendMonth.date.monthDayYearString
    }
    
    var displaySpend: String {
        currencyFormatter.stringAmount(spendMonth.spend)
    }
    
    var displayAllowance: String {
        currencyFormatter.stringAmount(spendMonth.allowance)
    }
    
    var displayDifference: String {
        let difference = spendMonth.allowance - spendMonth.spend
        return currencyFormatter.stringAmount(difference)
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
