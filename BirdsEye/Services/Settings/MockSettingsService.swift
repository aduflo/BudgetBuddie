//
//  MockSettingsService.swift
//  BirdsEye
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

class MockSettingsService: SettingsServiceable {
    private(set) var monthlyAllowance: Decimal = 0.0
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        self.monthlyAllowance = monthlyAllowance
    }
    
    private(set) var warningThreshold: Double = 0.0
    
    func setWarningThreshold(_ warningThreshold: Double) {
        self.warningThreshold = warningThreshold
    }
}
