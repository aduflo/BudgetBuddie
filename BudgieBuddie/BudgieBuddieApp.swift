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
    let userDefaults: UserDefaultsServiceable
    let settingsService: SettingsServiceable
    let calendarService: CalendarServiceable
    let currencyFormatter: CurrencyFormatter
    let spendRepository: SpendRepositable
    
    @Environment(\.scenePhase) private var scenePhase
    
    // Constructors
    init() {
        // initialize instance vars
        userDefaults = UserDefaultsService()
        settingsService = SettingsService(
            userDefaults: userDefaults
        )
        calendarService = CalendarService(
            todayDate: Date(),
            selectedDate: Date()
        )
        currencyFormatter = CurrencyFormatter()
        spendRepository = SpendRepository(
            userDefaults: userDefaults,
            store: SwiftDataSpendStore()
        )
        
        // start things up
        start()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen(
                screenModel: HomeScreenModel(
                    userDefaults: userDefaults,
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
    func start() {
        startDependencies()
        refresh()
    }
    
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
