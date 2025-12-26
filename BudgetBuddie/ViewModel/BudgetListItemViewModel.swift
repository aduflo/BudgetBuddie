//
//  BudgetListItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct BudgetListItemViewModel: Identifiable {
    // Instance vars
    let value: String
    
    // Identifiable
    let id = UUID()
}

// MARK: Public interface
extension BudgetListItemViewModel {
    var displayValue: String {
        "\(value)"
    }
}

// MARK: - Mocks
extension BudgetListItemViewModel {
    static func mock() -> Self {
        Self(value: "123")
    }
}
