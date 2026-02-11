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
}
