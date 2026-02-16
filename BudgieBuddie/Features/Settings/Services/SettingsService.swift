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
            forKey: .monthlyAllowance
        )
        return Decimal(floatLiteral: monthlyAllowance)
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        userDefaults.set(
            monthlyAllowance,
            forKey: .monthlyAllowance
        )
        NotificationCenter.default.post(.SettingsDidUpdateMonthlyAllowance)
    }
    
    var warningThreshold: Double {
        userDefaults.double(
            forKey: .warningThreshold
        )
    }
    
    func setWarningThreshold(_ warningThreshold: Double) {
        userDefaults.set(
            warningThreshold,
            forKey: .warningThreshold
        )
        NotificationCenter.default.post(.SettingsDidUpdateWarningThreshold)
    }
    
    var defaultSpendTrendViewpoint: SpendTrendViewpoint {
        let defaultSpendTrendViewpoint = userDefaults.integer(
            forKey: .defaultSpendTrendViewpoint
        )
        return SpendTrendViewpoint(
            rawValue: defaultSpendTrendViewpoint
        ) ?? .spendAllowance
    }
    
    func setDefaultSpendTrendViewpoint(_ defaultSpendTrendViewpoint: SpendTrendViewpoint) {
        userDefaults.set(
            defaultSpendTrendViewpoint.rawValue,
            forKey: .defaultSpendTrendViewpoint
        )
        NotificationCenter.default.post(.SettingsDidUpdateDefaultSpendTrendViewpoint)
    }
}
