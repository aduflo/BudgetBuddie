//
//  SettingsViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/24/25.
//

import Foundation

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
        postNotificationSettingsUpdated()
    }
    
    var warningThreshold: Double {
        settingsService.warningThreshold
    }
    
    func setWarningThreshold(_ warningThreshold: Double) {
        settingsService.setWarningThreshold(warningThreshold)
        postNotificationSettingsUpdated()
    }
}

// MARK: Private interface
private extension SettingsViewModel {
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
