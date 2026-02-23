//
//  CurrencyFormatter.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation

class CurrencyFormatter {
    // Instance vars
    private(set) var code: String = "USD"
}

// MARK: Public interface
extension CurrencyFormatter {
    func swapCurrencyCode(_ code: String) {
        self.code = code
    }
    
    var decimalFormatStyle: Decimal.FormatStyle.Currency {
        .currency(code: code)
    }
    
    func stringAmount(_ amount: Decimal) -> String {
        return amount.formatted(decimalFormatStyle)
    }
}
