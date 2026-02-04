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
                    do {
                        // need to update todayDate on foreground
                        // in case we had app in background on previous day,
                        // and opened on new day
                        // so that UI can adjust to new todayDate
                        calendarService.updateTodayDate(Date())
                        
                        // need to setup spendRepo on foreground
                        // in case we had app in background on previous month,
                        // and opened in a new month
                        // so that can be properly setup for this new month
                        // -------
                        // this is also the primary setup cue
                        // given need live references to calendarService and settingsService
                        // and would not have those availabile yet
                        // if leveraging spendRepo's constructor in app init
                        try spendRepository.setup(
                            calendarService: calendarService,
                            settingsService: settingsService
                        )
                    } catch {}
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
