//
//  SettingsServiceable.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

protocol SettingsServiceable {
    var monthlyAllowance: Decimal { get }
    func setMonthlyAllowance(_ monthlyAllowance: Decimal)
    var warningThreshold: Double { get }
    func setWarningThreshold(_ warningThreshold: Double)
    var defaultSpendTrendViewpoint: SpendTrendViewpoint { get }
    func setDefaultSpendTrendViewpoint(_ defaultSpendTrendViewpoint: SpendTrendViewpoint)
}
