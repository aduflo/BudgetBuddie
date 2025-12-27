//
//  CurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation

class CurrencyFormatter: CurrencyFormatting {
    // Instance vars
    private var currentFormatter: CurrencyFormatting = USDCurrencyFormatter()
    
    // Static vars
    static let shared: CurrencyFormatting = CurrencyFormatter()
    
    // CurrencyFormatting
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

extension CurrencyFormatter {
    func swapIn(formatter: CurrencyFormatting) {
        currentFormatter = formatter
    }
}
