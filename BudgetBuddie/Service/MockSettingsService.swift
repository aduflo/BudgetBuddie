//
//  MockSettingsService.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

class MockSettingsService: SettingsServicing {
    private(set) var monthlyAllowance: Decimal = 0.0
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        self.monthlyAllowance = monthlyAllowance
    }
    
    private(set) var toleranceThreshold: Double = 0.0
    
    func setToleranceThreshold(_ toleranceThreshold: Double) {
        self.toleranceThreshold = toleranceThreshold
    }
}
