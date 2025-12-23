//
//  CurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

protocol CurrencyFormatting {
    func stringDollarAmount(_ value: UInt) -> String
}

class CurrencyFormatter: CurrencyFormatting {
    // Instance vars
    let code: String
    private lazy var dollarFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        return formatter
    }()
    
    // Constructor
    init(code: String) {
        self.code = code
    }
}

// MARK: Public interface
extension CurrencyFormatter {
    static let shared = CurrencyFormatter(code: "USD")
    
    func stringDollarAmount(_ value: UInt) -> String {
        let dollarAmount = Decimal(value) / 100.0 // dividing by 100 to get dollar amount
        let decimalAmount = NSDecimalNumber(decimal: dollarAmount) // converting to formattable type
        return dollarFormatter.string(from: decimalAmount) ?? "N/A"
    }
}
