//
//  BudgetTolerance.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

struct BudgetTolerance {
    let threshold: Decimal
    
    enum Evaluation {
        case acceptable
        case encroaching
        case exceeded
    }
}

// MARK: Public interface
extension BudgetTolerance {
    func evaluate(spend: Decimal, max: Decimal) -> Evaluation {
        let percentage = spend / max
        return switch percentage {
        case 1...: .exceeded
        case threshold..<1: .encroaching
        default: .acceptable
        }
    }
}

// MARK: Stubs
extension BudgetTolerance {
    static func stub() -> Self {
        Self(threshold: 0.65)
    }
}
