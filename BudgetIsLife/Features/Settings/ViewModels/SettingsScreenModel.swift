//
//  SettingsScreenModel.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/24/25.
//

import Foundation

class SettingsScreenModel {
    // Instance vars
    private let settingsService: SettingsServiceable
    let currencyFormatter: CurrencyFormatter
    
    var defaultSpendTrendViewpoint: SpendTrendViewpoint {
        didSet {
            settingsService.setDefaultSpendTrendViewpoint(defaultSpendTrendViewpoint)
        }
    }
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        currencyFormatter: CurrencyFormatter
    ) {
        self.settingsService = settingsService
        self.currencyFormatter = currencyFormatter
        defaultSpendTrendViewpoint = settingsService.defaultSpendTrendViewpoint
    }
}

// MARK: Public interface
extension SettingsScreenModel {
    var monthlyAllowance: Decimal {
        settingsService.monthlyAllowance
    }
    
    func setMonthlyAllowance(_ monthlyAllowance: Decimal?) {
        settingsService.setMonthlyAllowance(monthlyAllowance ?? 0.0)
    }
    
    var warningThreshold: Double {
        settingsService.warningThreshold
    }
    
    func setWarningThreshold(_ warningThreshold: Double) {
        settingsService.setWarningThreshold(warningThreshold)
    }
    
    var displayVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? Copy.notAvailable
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? Copy.notAvailable
        return "\(Copy.appName) v\(version) (\(build))"
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
