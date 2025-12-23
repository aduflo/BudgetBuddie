//
//  BudgetRundownViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation
import SwiftUI

struct BudgetRundownViewModel {
    let dailySpend: UInt // amount in cents
    let dailyMax: UInt // amount in cents
    private let dollarFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()
}

// MARK: Public interface
extension BudgetRundownViewModel {
    var displayDate: String {
        "Dec. 12th, 2025"
    }
    
    var displayDailySpend: String {
        return displayDollarAmount(dailySpend)
    }
    
    var displayDailyMax: String {
        return displayDollarAmount(dailyMax)
    }
    
    var dailySpendColor: Color {
        let decimalSpend = Decimal(dailySpend)
        let decimalMax = Decimal(dailyMax)
        let percentage = decimalSpend / decimalMax
        return switch percentage {
        case 1...: .red // we've exceeded daily limit
        case 0.65..<1: .yellow // we're encroaching on daily limit
        default: .green // we're comfortably below daily limit
        }
    }
}

// MARK: Private interface
private extension BudgetRundownViewModel {
    func displayDollarAmount(_ value: UInt) -> String {
        let dollarAmount = Decimal(value) / 100.0 // dividing by 100 to get dollar amount
        let decimalAmount = NSDecimalNumber(decimal: dollarAmount) // converting to formattable type
        return dollarFormatter.string(from: decimalAmount) ?? "N/A"
    }
}

// MARK: Stubs
extension BudgetRundownViewModel {
    static func stub() -> Self {
        Self(
            dailySpend: 5453,
            dailyMax: 6500
        )
    }
}
