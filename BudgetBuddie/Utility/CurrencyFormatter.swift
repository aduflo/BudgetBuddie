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
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()
}

// MARK: Public interface
extension CurrencyFormatter {
    static let shared = CurrencyFormatter()
    
    func stringDollarAmount(_ value: UInt) -> String {
        let dollarAmount = Decimal(value) / 100.0 // dividing by 100 to get dollar amount
        let decimalAmount = NSDecimalNumber(decimal: dollarAmount) // converting to formattable type
        return formatter.string(from: decimalAmount) ?? "N/A"
    }
}
