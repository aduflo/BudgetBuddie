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
    @Environment(\.settingsService) private var settingsService
    @Environment(\.calendarService) private var calendarService
    @Environment(\.currencyFormatter) private var currencyFormatter
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: HomeViewModel(
                    settingsService: settingsService,
                    calendarService: calendarService,
                    spendRepository: SpendRepository( // FIXME: this needs to be in instance var, it's getting constructed everytime view is redrawn
                        spendStore: InMemorySpendStore(),
                        calendarService: calendarService
                    ),
                    currencyFormatter: currencyFormatter
                )
            )
        }
    }
}
