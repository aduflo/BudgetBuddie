//
//  BudgetRundownViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation
import SwiftUI

struct BudgetRundownViewModel {
    // Instance vars
    let dailySpend: UInt // amount in cents
    let dailyMax: UInt // amount in cents
    let tolerance: BudgetTolerance
    
    // Instance vars (utility)
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
        return switch tolerance.evaluate(
            spend: Decimal(dailySpend),
            max: Decimal(dailyMax)
        ) {
        case .acceptable: .green
        case .encroaching: .yellow
        case .exceeded: .red
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
            dailyMax: 6500,
            tolerance: .stub()
        )
    }
}
