//
//  SettingsService.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

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
        postNotificationSettingsUpdated()
    }
    
    var warningThreshold: Double {
        userDefaults.object(forKey: Key.warningThreshold) as? Double ?? 0.0
    }
    
    func setWarningThreshold(_ warningThreshold: Double) {
        userDefaults.set(warningThreshold, forKey: Key.warningThreshold)
        postNotificationSettingsUpdated()
    }
}

// MARK: Private interface
private extension SettingsService {
    struct Key {
        static let monthlyAllowance = "monthlyAllowance"
        static let warningThreshold = "warningThreshold"
    }
    
    func postNotificationSettingsUpdated() {
        NotificationCenter.default.post(.SettingsUpdated)
    }
}
