//
//  BudgieBuddieApp.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

@main
struct BudgieBuddieApp: App {
    // Instance vars
    let settingsService: SettingsServiceable = SettingsService()
    let calendarService: CalendarServiceable = CalendarService()
    let currencyFormatter: CurrencyFormatter = CurrencyFormatter()
    let spendRepository: SpendRepositable = SpendRepository()
    
    @Environment(\.scenePhase) private var scenePhase
    
    // Constructors
    init() {
        startDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen(
                screenModel: HomeScreenModel(
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

// MARK: Private interface
private extension BudgieBuddieApp {
    func startDependencies() {
        ObservabilityService.start()
    }
}
