//
//  BirdsEyeApp.swift
//  BirdsEye
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

@main
struct BirdsEyeApp: App {
    // Instance vars
    let settingsService: SettingsServiceable = SettingsService()
    let calendarService: CalendarServiceable = CalendarService()
    let currencyFormatter: CurrencyFormatter = CurrencyFormatter()
    let spendRepository: SpendRepositable = SpendRepository()
    
    @Environment(\.scenePhase) private var scenePhase
    
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
            .onChange(of: scenePhase) { _, newValue in
                if newValue == .active {
                    spendRepository.setup(
                        settingsService: settingsService
                    )
                }
            }
        }
    }
}
