//
//  USDCurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

class USDCurrencyFormatter: CurrencyFormattable {
    // CurrencyFormattable
    let code = "USD"
    
    var decimalFormatStyle: Decimal.FormatStyle.Currency {
        .currency(code: code)
    }
    
    func stringAmount(_ amount: Decimal) -> String {
        return amount.formatted(.currency(code: code))
    }
}
