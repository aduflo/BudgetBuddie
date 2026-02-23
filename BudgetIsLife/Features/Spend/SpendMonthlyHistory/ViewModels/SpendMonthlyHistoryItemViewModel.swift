//
//  SpendMonthlyHistoryItemViewModel.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/18/26.
//

import Foundation

struct SpendMonthlyHistoryItemViewModel: Identifiable {
    // Instance vars
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    let spendMonth: SpendMonth
    
    // Identifiable
    let id = UUID()
    
    // Constructors
    init(
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter,
        spendMonth: SpendMonth
    ) {
        self.spendRepository = spendRepository
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
        currencyFormatter.stringAmount(spend)
    }
    
    var displayAllowance: String {
        currencyFormatter.stringAmount(allowance)
    }
    
    var isWithinBudget: Bool {
        spend <= allowance
    }
    
    var displayBudgetDifference: String {
        let budgetDifference = allowance - spend
        return currencyFormatter.stringAmount(budgetDifference)
    }
}

// MARK: Private interface
private extension SpendMonthlyHistoryItemViewModel {
    var spend: Decimal {
        do {
            return try MonthSpendCalculator.calculateSpend(
                month: spendMonth,
                spendRepository: spendRepository
            )
        } catch {
            return 0.0
        }
    }
    
    var allowance: Decimal {
        spendMonth.allowance
    }
}

// MARK: - Mocks
extension SpendMonthlyHistoryItemViewModel {
    static func mock() -> SpendMonthlyHistoryItemViewModel {
        SpendMonthlyHistoryItemViewModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
    }
}
