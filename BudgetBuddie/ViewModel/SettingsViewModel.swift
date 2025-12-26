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
    let settingsService: SettingsServicing
    let currencyFormatter: CurrencyFormatting
    
    init(
        settingsService: SettingsServicing,
        currencyFormatter: CurrencyFormatting = CurrencyFormatter.shared
    ) {
        self.settingsService = settingsService
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension SettingsViewModel {
    var monthlyAllowance: Decimal {
        settingsService.monthlyAllowance
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        settingsService.setMonthlyAllowance(monthlyAllowance)
    }
    
    var toleranceThreshold: Double {
        settingsService.toleranceThreshold
    }
    
    func setToleranceThreshold(_ toleranceThreshold: Double) {
        settingsService.setToleranceThreshold(toleranceThreshold)
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
        SettingsViewModel(settingsService: MockSettingsService())
    }
}
