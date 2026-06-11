//
//  SpendTrendViewpoint.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 2/9/26.
//

import Foundation

enum SpendTrendViewpoint: Int {
    case spendAllowance
    case remainingOverspend
    case surplus
}

// MARK: Public interface
extension SpendTrendViewpoint {
    mutating func cycle() {
        let newValue: Self? = if let nextValue = Self(rawValue: rawValue + 1) {
            nextValue
        } else if let firstValue = Self(rawValue: 0) {
            firstValue
        } else {
            nil // initialization failed
        }
        
        guard let newValue else {
            return
        }
        
        self = newValue
    }
    
    var displayValue: String {
        switch self {
        case .spendAllowance:
            Copy.spend
        case .remainingOverspend:
            Copy.remaining
        case .surplus:
            Copy.surplus
        }
    }
}

extension SpendTrendViewpoint: Identifiable {
    var id: Int { rawValue }
}
extension SpendTrendViewpoint: CaseIterable {}
