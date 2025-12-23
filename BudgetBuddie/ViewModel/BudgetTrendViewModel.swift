//
//  BudgetTrendViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation
import SwiftUI

struct BudgetTrendViewModel {
    // Instance vars
    let title: String
    let currentSpend: UInt // amount in cents
    let maxSpend: UInt // amount in cents
    let tolerance: BudgetTolerance
    let currencyFormatter: CurrencyFormatting
}

// MARK: Public interface
extension BudgetTrendViewModel {
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
        case .encroaching: .orange
        case .exceeded: .red
        }
    }
}

// MARK: Mocks
extension BudgetTrendViewModel {
    static func mock() -> Self {
        Self(
            title: "Daily",
            currentSpend: 900001,
            maxSpend: 900000,
            tolerance: .mock(),
            currencyFormatter: USDCurrencyFormatter.shared
        )
    }
}
