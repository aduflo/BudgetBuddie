//
//  SettingsService.swift
//  BirdsEye
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

class SettingsService: SettingsServiceable {
    // Instance vars
    private let userDefaults: UserDefaults = .standard
    
    // SettingsServiceable
    var monthlyAllowance: Decimal {
        let monthlyAllowance = userDefaults.double(
            forKey: UserDefaults.Key.Settings.monthlyAllowance
        )
        return Decimal(floatLiteral: monthlyAllowance)
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        userDefaults.set(
            monthlyAllowance,
            forKey: UserDefaults.Key.Settings.monthlyAllowance
        )
        postNotificationSettingsUpdated()
    }
    
    var warningThreshold: Double {
        userDefaults.double(
            forKey: UserDefaults.Key.Settings.warningThreshold
        )
    }
    
    func setWarningThreshold(_ warningThreshold: Double) {
        userDefaults.set(
            warningThreshold,
            forKey: UserDefaults.Key.Settings.warningThreshold
        )
        postNotificationSettingsUpdated()
    }
}

// MARK: Private interface
private extension SettingsService {
    func postNotificationSettingsUpdated() {
        NotificationCenter.default.post(.SettingsDidUpdate)
    }
}
