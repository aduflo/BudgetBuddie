//
//  SpendMonthSummaryScreenModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/17/26.
//

import Foundation

@Observable
class SpendMonthSummaryScreenModel {
    // Instance vars
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    private let date: Date
    
    private let spendMonth: SpendMonth?
    let error: Error?
    
    // Constructors
    init(
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter,
        date: Date
    ) {
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        self.date = date
        
        do {
            spendMonth = try spendRepository.getMonth(
                date: date
            )
            error = nil
        } catch {
            spendMonth = nil
            self.error = error
        }
    }
}

// MARK: Public interface
extension SpendMonthSummaryScreenModel {
    var displayMonth: String {
        guard let date = spendMonth?.date else {
            return ""
        }
        
        return date.monthLongString
    }
    
    var displaySpend: String {
        guard let spend else {
            return ""
        }
        
        return currencyFormatter.stringAmount(spend)
    }
    
    var displayAllowance: String {
        guard let allowance else {
            return ""
        }
        
        return currencyFormatter.stringAmount(allowance)
    }
    
    var isWithinBudget: Bool {
        guard let spend, let allowance else {
            return false
        }
        
        return spend <= allowance
    }
    
    var displayBudgetDifference: String {
        guard let spend, let allowance else {
            return ""
        }
        
        let budgetDifference = allowance - spend
        return currencyFormatter.stringAmount(budgetDifference)
    }
}

// MARK: Private interface
private extension SpendMonthSummaryScreenModel {
    var spend: Decimal? {
        guard let spendMonth else {
            return nil
        }
        
        do {
            return try MonthSpendCalculator.calculateSpend(
                month: spendMonth,
                spendRepository: spendRepository
            )
        } catch {
            return 0.0
        }
    }
    
    var allowance: Decimal? {
        spendMonth?.allowance ?? nil
    }
}

// MARK: - Mocks
extension SpendMonthSummaryScreenModel {
    static func mock() -> SpendMonthSummaryScreenModel {
        SpendMonthSummaryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
    }
}
