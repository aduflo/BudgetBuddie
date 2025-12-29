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
    @Entry var calendarService: CalenderServiceable = CalenderService()
    @Entry var spendRepository: SpendRepository = SpendRepository()
    @Entry var currencyFormatter: CurrencyFormatter = CurrencyFormatter()
}
