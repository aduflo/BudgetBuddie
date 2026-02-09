//
//  SpendTrendViewpoint.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 2/9/26.
//

import Foundation

enum SpendTrendViewpoint {
    case spendAllowance
    case remaining
    
    mutating func toggle() {
        switch self {
        case .spendAllowance:
            self = .remaining
        case .remaining:
            self = .spendAllowance
        }
    }
}
