//
//  BudgetBuddieApp.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

@main
struct BudgetBuddieApp: App {
    // Instance vars
    @Environment(\.settingsService) var settingsService
    @Environment(\.spendRepository) var spendRepository
    @Environment(\.currencyFormatter) var currencyFormatter
    
    var body: some Scene {
        WindowGroup {
            BudgetView(
                viewModel: BudgetViewModel(
                    rundownViewModel: BudgetRundownViewModel(
                        selectedDate: Date(),
                        settingsService: settingsService,
                        spendRepository: spendRepository,
                        currencyFormatter: currencyFormatter
                    ),
                    listViewModel: BudgetListViewModel(
                        spendRepository: spendRepository
                    ),
                    settingsViewModel: SettingsViewModel(
                        settingsService: settingsService,
                        currencyFormatter: currencyFormatter
                    )
                )
            )
        }
    }
}
