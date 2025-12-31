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
                    settingsService: settingsService,
                    calendarService: calendarService,
                    spendRepository: spendRepository,
                    currencyFormatter: currencyFormatter
                )
            )
        }
    }
}
