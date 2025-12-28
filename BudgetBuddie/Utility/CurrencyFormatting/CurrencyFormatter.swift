//
//  CurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation

class CurrencyFormatter: CurrencyFormattable {
    // Instance vars
    private(set) var currentFormatter: CurrencyFormattable = USDCurrencyFormatter()
    
    // CurrencyFormattable
    var code: String {
        currentFormatter.code
    }
    
    var decimalFormatStyle: Decimal.FormatStyle.Currency {
        currentFormatter.decimalFormatStyle
    }
    
    func stringAmount(_ amount: Decimal) -> String {
        currentFormatter.stringAmount(amount)
    }
}

// MARK: Public interface
extension CurrencyFormatter {
    func swapIn(formatter: CurrencyFormattable) {
        currentFormatter = formatter
    }
}
