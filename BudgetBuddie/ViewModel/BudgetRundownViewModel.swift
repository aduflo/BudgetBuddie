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
    let currentSpend: UInt // amount in cents
    let maxSpend: UInt // amount in cents
    let tolerance: BudgetTolerance
    let currencyFormatter: CurrencyFormatting
}

// MARK: Public interface
extension BudgetRundownViewModel {
    var displayDate: String {
        "Dec. 12th, 2025"
    }
    
    var displayCurrentSpend: String {
        return currencyFormatter.stringAmount(currentSpend)
    }
    
    var displayMaxSpend: String {
        return currencyFormatter.stringAmount(maxSpend)
    }
    
    var dailySpendColor: Color {
        return switch tolerance.evaluate(
            spend: Decimal(currentSpend),
            max: Decimal(maxSpend)
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
            currentSpend: 900001,
            maxSpend: 900000,
            tolerance: .mock(),
            currencyFormatter: USDCurrencyFormatter.shared
        )
    }
}
