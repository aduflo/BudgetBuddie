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
    let calendarService: CalendarServiceable = CalendarService(
        todayDate: Date(),
        selectedDate: Date()
    )
    let currencyFormatter: CurrencyFormatter = CurrencyFormatter()
    let spendRepository: SpendRepositable = SpendRepository()
    
    @Environment(\.scenePhase) private var scenePhase
    
    // Constructors
    init() {
        startDependencies()
        refresh()
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
                    // need to call refresh() on foreground (.active),
                    // in case we had app in background on previous day
                    // and re-opened app on new day (which also could be first day of new month),
                    // so that UI can reflect most up-to-date data
                    refresh()
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
    
    func refresh() {
        do {
            calendarService.updateTodayDate(Date())
            try spendRepository.setup(
                calendarService: calendarService,
                settingsService: settingsService
            )
        } catch {}
    }
}
