//
//  CurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation

class CurrencyFormatter: CurrencyFormattable {
    // Instance vars
    private var formatter: CurrencyFormattable = USDCurrencyFormatter()
    
    // CurrencyFormattable
    var code: String {
        formatter.code
    }
    
    var decimalFormatStyle: Decimal.FormatStyle.Currency {
        formatter.decimalFormatStyle
    }
    
    func stringAmount(_ amount: Decimal) -> String {
        formatter.stringAmount(amount)
    }
}

// MARK: Public interface
extension CurrencyFormatter {
    func swapIn(formatter: CurrencyFormattable) {
        self.formatter = formatter
    }
}
