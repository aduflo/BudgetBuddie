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
                    spendViewModel: SpendViewModel(
                        spendListViewModel: .mock(),
                        calendarViewModel: CalendarViewModel(
                            calendarService: calendarService
                        ),
//                        spendListViewModel: SpendListViewModel( // TODO: use this once ready
//                            spendRepository: spendRepository,
//                            currencyFormatter: currencyFormatter
//                        )
                    )
                )
            )
        }
    }
}
