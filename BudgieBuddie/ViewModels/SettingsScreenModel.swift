//
//  SettingsScreenModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/24/25.
//

import Foundation

class SettingsScreenModel {
    // Instance vars
    private let settingsService: SettingsServiceable
    let currencyFormatter: CurrencyFormatter
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        currencyFormatter: CurrencyFormatter
    ) {
        self.settingsService = settingsService
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension SettingsScreenModel {
    var monthlyAllowance: Decimal {
        settingsService.monthlyAllowance
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal) {
        settingsService.setMonthlyAllowance(monthlyAllowance)
    }
    
    var warningThreshold: Double {
        settingsService.warningThreshold
    }
    
    func setWarningThreshold(_ warningThreshold: Double) {
        settingsService.setWarningThreshold(warningThreshold)
    }
}

// MARK: - Mocks
extension SettingsScreenModel {
    static func mock() -> SettingsScreenModel {
        SettingsScreenModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
