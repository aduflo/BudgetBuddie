//
//  CurrencyFormatter.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

protocol CurrencyFormatting {
    static var shared: CurrencyFormatting { get }
    func stringAmount(_ value: UInt) -> String
}
