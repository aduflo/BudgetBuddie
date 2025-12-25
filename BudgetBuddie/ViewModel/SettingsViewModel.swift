//
//  SettingsViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/24/25.
//

import Foundation

@Observable
class SettingsViewModel {
    // Instance vars
    let settingsRepo: SettingsRepoing
    let currencyFormatter: CurrencyFormatting
    
    init(
        settingsRepo: SettingsRepoing,
        currencyFormatter: CurrencyFormatting = CurrencyFormatter.shared
    ) {
        self.settingsRepo = settingsRepo
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension SettingsViewModel {
    var monthlyAllowance: Decimal {
        settingsRepo.monthlyAllowance
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        settingsRepo.setMonthlyAllowance(monthlyAllowance)
    }
    
    var toleranceThreshold: Double {
        settingsRepo.toleranceThreshold
    }
    
    func setToleranceThreshold(_ toleranceThreshold: Double) {
        settingsRepo.setToleranceThreshold(toleranceThreshold)
    }
    
    var displayToleranceThreshold: String {
        "Tolerance threshold: \(toleranceThreshold.formatted(.percent))"
    }
    
    func postNotificationSettingsUpdated() {
        NotificationCenter.default.post(.SettingsUpdated)
    }
}

// MARK: - Mocks
extension SettingsViewModel {
    static func mock() -> SettingsViewModel {
        SettingsViewModel(settingsRepo: MockSettingsRepo())
    }
}
