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
            HomeView(
                viewModel: HomeViewModel(
                    rundownViewModel: BudgetRundownViewModel(
                        settingsService: settingsService,
                        calendarService: calendarService,
                        spendRepository: spendRepository,
                        currencyFormatter: currencyFormatter
                    ),
                    settingsViewModel: SettingsViewModel(
                        settingsService: settingsService,
                        currencyFormatter: currencyFormatter
                    ),
                    spendViewModel: SpendViewModel(
                        calendarViewModel: CalendarViewModel(
                            calendarService: calendarService
                        ),
                        spendListViewModel: .mock(),
//                        spendListViewModel: SpendListViewModel( // TODO: rethink this pattern. perhaps put this VMs as builders inside SpendViewModel instead of initializing them here. that way, they're initialized on first use and reassignable? maybe these are tired thoughts.
//                            spendRepository: spendRepository,
//                            currencyFormatter: currencyFormatter
//                        ),
                        calendarService: calendarService,
                        spendRepository: spendRepository,
                        currencyFormatter: currencyFormatter
                    )
                )
            )
        }
    }
}
