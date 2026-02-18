//
//  SpendTrendViewpoint.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 2/9/26.
//

import Foundation

enum SpendTrendViewpoint: Int {
    case spendAllowance
    case remainingOverspend
}

// MARK: Public interface
extension SpendTrendViewpoint {
    mutating func cycle() {
        let currentRawValue = rawValue
        let newRawValue = currentRawValue + 1
        if let newValue = SpendTrendViewpoint(rawValue: newRawValue) {
            self = newValue
        } else if let firstCaseValue = SpendTrendViewpoint(rawValue: 0) {
            self = firstCaseValue
        } else {
            self = .spendAllowance
        }
    }
    
    var displayValue: String {
        switch self {
        case .spendAllowance:
            "\(Copy.spend) / \(Copy.allowance)"
        case .remainingOverspend:
            "\(Copy.remaining) / \(Copy.overspend)"
        }
    }
}

extension SpendTrendViewpoint: Identifiable {
    var id: Int { rawValue }
}
extension SpendTrendViewpoint: CaseIterable {}
