//
//  SettingsRepo.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

// TODO: use Mutexes for thread safety on set/get

class SettingsRepo: SettingsRepoing {
    // Instance vars
    private let userDefaults: UserDefaults = .standard
}

private extension SettingsRepo {
    struct Key {
        static let monthlyAllowance = "monthlyAllowance"
        static let toleranceThreshold = "toleranceThreshold"
    }
}

// MARK: Public interface
extension SettingsRepo {
    var monthlyAllowance: Decimal {
        let monthlyAllowance = userDefaults.object(forKey: Key.monthlyAllowance) as? Double ?? 0.0
        return Decimal(floatLiteral: monthlyAllowance)
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        userDefaults.set(monthlyAllowance, forKey: Key.monthlyAllowance)
    }
    
    var toleranceThreshold: Double {
        userDefaults.object(forKey: Key.toleranceThreshold) as? Double ?? 0.0
    }
    func setToleranceThreshold(_ toleranceThreshold: Double) {
        userDefaults.set(toleranceThreshold, forKey: Key.toleranceThreshold)
    }
}
