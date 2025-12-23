//
//  USDCurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

class USDCurrencyFormatter: CurrencyFormatting {
    // Instance vars
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        return formatter
    }()
    
    // CurrencyFormatting
    static let shared: CurrencyFormatting = USDCurrencyFormatter()
    let code = "USD"
    
    func stringAmount(_ value: UInt) -> String {
        let dollarAmount = Decimal(value) / 100.0 // dividing by 100 to get dollar amount
        let decimalAmount = NSDecimalNumber(decimal: dollarAmount) // converting to formattable type
        return formatter.string(from: decimalAmount) ?? "N/A"
    }
}
