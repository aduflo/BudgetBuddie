//
//  SettingsService.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

class SettingsService: SettingsServiceable {
    // Instance vars
    private let userDefaults: UserDefaultsServiceable
    
    // Constructor
    init(
        userDefaults: UserDefaultsServiceable
    ) {
        self.userDefaults = userDefaults
    }
    
    // SettingsServiceable
    var monthlyAllowance: Decimal {
        let monthlyAllowance = userDefaults.double(
            forKey: UserDefaultsKey.Settings.monthlyAllowance
        )
        return Decimal(floatLiteral: monthlyAllowance)
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        userDefaults.set(
            monthlyAllowance,
            forKey: UserDefaultsKey.Settings.monthlyAllowance
        )
        NotificationCenter.default.post(.SettingsDidUpdateMonthlyAllowance)
    }
    
    var warningThreshold: Double {
        userDefaults.double(
            forKey: UserDefaultsKey.Settings.warningThreshold
        )
    }
    
    func setWarningThreshold(_ warningThreshold: Double) {
        userDefaults.set(
            warningThreshold,
            forKey: UserDefaultsKey.Settings.warningThreshold
        )
        NotificationCenter.default.post(.SettingsDidUpdateWarningThreshold)
    }
    
    var defaultSpendTrendViewpoint: SpendTrendViewpoint {
        let defaultSpendTrendViewpoint = userDefaults.integer(
            forKey: UserDefaultsKey.Settings.defaultSpendTrendViewpoint
        )
        return SpendTrendViewpoint(
            rawValue: defaultSpendTrendViewpoint
        ) ?? .spendAllowance
    }
    
    func setDefaultSpendTrendViewpoint(_ defaultSpendTrendViewpoint: SpendTrendViewpoint) {
        userDefaults.set(
            defaultSpendTrendViewpoint.rawValue,
            forKey: UserDefaultsKey.Settings.defaultSpendTrendViewpoint
        )
        NotificationCenter.default.post(.SettingsDidUpdateDefaultSpendTrendViewpoint)
    }
}
