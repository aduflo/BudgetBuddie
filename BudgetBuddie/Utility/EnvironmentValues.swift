//
//  EnvironmentValues.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var settingsService: SettingsServicing = SettingsService()
}

//extension View {
//    EG.
//    func setMonthlyAllowance(_ monthlyAllowance: Decimal) -> some View {
//        environment(\.monthlyAllowance, monthlyAllowance)
//    }
//}
