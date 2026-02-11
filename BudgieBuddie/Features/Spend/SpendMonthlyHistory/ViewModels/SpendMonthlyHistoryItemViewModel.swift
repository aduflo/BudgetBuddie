//
//  SpendMonthlyHistoryItemViewModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import Foundation

struct SpendMonthlyHistoryItemViewModel: Identifiable {
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
extension SpendMonthlyHistoryItemViewModel {
    var displayDate: String {
        spendMonth.date.monthYearString
    }
    
    var displaySpend: String {
        currencyFormatter.stringAmount(spendMonth.spend)
    }
    
    var displayAllowance: String {
        currencyFormatter.stringAmount(spendMonth.allowance)
    }
    
    var isSpendWithinBudget: Bool {
        spendMonth.spend <= spendMonth.allowance
    }
    
    var displaySpendDifference: String {
        let difference = spendMonth.allowance - spendMonth.spend
        return currencyFormatter.stringAmount(difference)
    }
}

// MARK: - Mocks
extension SpendMonthlyHistoryItemViewModel {
    static func mock() -> SpendMonthlyHistoryItemViewModel {
        SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
    }
}
