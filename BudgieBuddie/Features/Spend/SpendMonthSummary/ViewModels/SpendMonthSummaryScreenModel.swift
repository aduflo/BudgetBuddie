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
        guard let spend = spendMonth?.spend else {
            return ""
        }
        
        return currencyFormatter.stringAmount(spend)
    }
    
    var displayAllowance: String {
        guard let allowance = spendMonth?.allowance else {
            return ""
        }
        
        return currencyFormatter.stringAmount(allowance)
    }
    
    var isWithinBudget: Bool {
        guard let spendMonth else {
            return false
        }
        
        return spendMonth.isWithinBudget
    }
    
    var displayBudgetDifference: String {
        guard let spendMonth else {
            return ""
        }
        
        return currencyFormatter.stringAmount(spendMonth.budgetDifference)
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
