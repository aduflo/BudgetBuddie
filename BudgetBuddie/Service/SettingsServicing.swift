//
//  SettingsServicing.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

protocol SettingsServicing {
    var monthlyAllowance: Decimal { get }
    func setMonthlyAllowance(_ monthlyAllowance: Decimal)
    
    var toleranceThreshold: Double { get }
    func setToleranceThreshold(_ toleranceThreshold: Double)
}
