//
//  SettingsService.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

// TODO: use Mutexes for thread safety on set/get

class SettingsService: SettingsServiceable {
    // Instance vars
    private let userDefaults: UserDefaults = .standard
    
    // SettingsServiceable
    var monthlyAllowance: Decimal {
        let monthlyAllowance = userDefaults.object(forKey: Key.monthlyAllowance) as? Double ?? 0.0
        return Decimal(floatLiteral: monthlyAllowance)
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        userDefaults.set(monthlyAllowance, forKey: Key.monthlyAllowance)
    }
    
    var warningThreshold: Double {
        userDefaults.object(forKey: Key.warningThreshold) as? Double ?? 0.0
    }
    
    func setWarningThreshold(_ warningThreshold: Double) {
        userDefaults.set(warningThreshold, forKey: Key.warningThreshold)
    }
}

private extension SettingsService {
    struct Key {
        static let monthlyAllowance = "monthlyAllowance"
        static let warningThreshold = "warningThreshold"
    }
}
