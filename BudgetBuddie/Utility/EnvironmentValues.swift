//
//  EnvironmentValues.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var settingsService: SettingsServiceable = SettingsService()
    @Entry var spendRepository: SpendRepository = SpendRepository()
    @Entry var currencyFormatter: CurrencyFormatter = CurrencyFormatter()
}

//extension View {
//    EG.
//    func setMonthlyAllowance(_ monthlyAllowance: Decimal) -> some View {
//        environment(\.monthlyAllowance, monthlyAllowance)
//    }
//}
