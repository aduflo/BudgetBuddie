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
    
    private(set) var spendMonth: SpendMonth?
    private(set) var error: Error? = nil
    
    // Constructors
    init(
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter,
        date: Date
    ) {
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        self.date = date
    }
}

// MARK: Public interface
extension SpendMonthSummaryScreenModel {
    func reloadData() {
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
    
    var isSpendWithinBudget: Bool {
        guard let spendMonth else {
            return false
        }
        
        return spendMonth.spend <= spendMonth.allowance
    }
    
    var displaySpendDifference: String {
        guard let spendMonth else {
            return ""
        }
        
        let difference = spendMonth.allowance - spendMonth.spend
        return currencyFormatter.stringAmount(difference)
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
