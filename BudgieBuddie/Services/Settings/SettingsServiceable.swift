//
//  SettingsServiceable.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

protocol SettingsServiceable {
    var monthlyAllowance: Decimal { get }
    func setMonthlyAllowance(_ monthlyAllowance: Decimal)
    var warningThreshold: Double { get }
    func setWarningThreshold(_ warningThreshold: Double)
}
