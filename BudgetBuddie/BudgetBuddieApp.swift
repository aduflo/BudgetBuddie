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
    @Environment(\.calendarService) var calendarService
    @Environment(\.spendRepository) var spendRepository
    @Environment(\.currencyFormatter) var currencyFormatter
    
    var body: some Scene {
        WindowGroup {
            BudgetView(
                viewModel: BudgetViewModel(
                    rundownViewModel: BudgetRundownViewModel(
                        selectedDate: Date(), // TODO: leverage date picker selection
                        settingsService: settingsService,
                        calendarService: calendarService,
                        spendRepository: spendRepository,
                        currencyFormatter: currencyFormatter
                    ),
//                    listViewModel: BudgetListViewModel(
//                        spendRepository: spendRepository,
//                        currencyFormatter: currencyFormatter
//                    ),
                    listViewModel: .mock(), // TODO: use above
                    settingsViewModel: SettingsViewModel(
                        settingsService: settingsService,
                        currencyFormatter: currencyFormatter
                    )
                )
            )
        }
    }
}
