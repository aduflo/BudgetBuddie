//
//  CurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation

class CurrencyFormatter: CurrencyFormatting {
    // Instance vars
    private var currentFormatter: CurrencyFormatting = USDCurrencyFormatter.shared
    
    // CurrencyFormatting
    static let shared: CurrencyFormatting = CurrencyFormatter()
    var code: String { currentFormatter.code }
    
    func stringAmount(_ value: UInt) -> String {
        currentFormatter.stringAmount(value)
    }
}

extension CurrencyFormatter {
    func swapIn(formatter: CurrencyFormatting) {
        currentFormatter = formatter
    }
}
