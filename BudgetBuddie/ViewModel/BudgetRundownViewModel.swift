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
    let currencyFormatter: CurrencyFormatting
}

// MARK: Public interface
extension BudgetRundownViewModel {
    var displayDate: String {
        "Dec. 12th, 2025"
    }
    
    var displayDailySpend: String {
        return currencyFormatter.stringAmount(dailySpend)
    }
    
    var displayDailyMax: String {
        return currencyFormatter.stringAmount(dailyMax)
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

// MARK: Mocks
extension BudgetRundownViewModel {
    static func mock() -> Self {
        Self(
            dailySpend: 5453,
            dailyMax: 6500,
            tolerance: .mock(),
            currencyFormatter: USDCurrencyFormatter.shared
        )
    }
}
