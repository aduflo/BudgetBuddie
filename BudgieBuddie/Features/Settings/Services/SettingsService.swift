//
//  SettingsService.swift
//  BudgieBuddie
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
        NotificationCenter.default.post(.SettingsDidUpdateMonthlyAllowance)
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
        NotificationCenter.default.post(.SettingsDidUpdateWarningThreshold)
    }
    
    var defaultSpendTrendViewpoint: SpendTrendViewpoint {
        let defaultSpendTrendViewpoint = userDefaults.integer(
            forKey: UserDefaults.Key.Settings.defaultSpendTrendViewpoint
        )
        return SpendTrendViewpoint(
            rawValue: defaultSpendTrendViewpoint
        ) ?? .spendAllowance
    }
    
    func setDefaultSpendTrendViewpoint(_ defaultSpendTrendViewpoint: SpendTrendViewpoint) {
        userDefaults.set(
            defaultSpendTrendViewpoint.rawValue,
            forKey: UserDefaults.Key.Settings.defaultSpendTrendViewpoint
        )
        NotificationCenter.default.post(.SettingsDidUpdateDefaultSpendTrendViewpoint)
    }
}
