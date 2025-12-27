//
//  CurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

protocol CurrencyFormatting {
    var code: String { get }
    var decimalFormatStyle: Decimal.FormatStyle.Currency { get }
    func stringAmount(_ amount: Decimal) -> String
}
