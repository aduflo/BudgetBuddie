//
//  BudgetIsLifeApp.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

@main
struct BudgetIsLifeApp: App {
    // Instance vars
    let userDefaults: UserDefaultsServiceable
    let settingsService: SettingsServiceable
    let calendarService: CalendarServiceable
    let currencyFormatter: CurrencyFormatter
    let spendRepository: SpendRepositable
    
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
            .onAppear {
                reloadData()
            }
            .onReceive(
                NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification),
                perform: { _ in
                    Task { await MainActor.run {
                        // need to call reloadData() on foreground,
                        // in case we had app in background on previous day
                        // and re-opened app on new day
                        // so that UI can reflect most up-to-date data
                        reloadData()
                    }}
                }
            )
        }
    }
}

// MARK: Private interface
private extension BudgetIsLifeApp {
    func start() {
        startDependencies()
    }
    
    func startDependencies() {
        ObservabilityService.start()
    }
    
    func reloadData() {
        do {
            calendarService.updateTodayDate(Date())
            try spendRepository.setup(
                calendarService: calendarService,
                settingsService: settingsService
            )
        } catch {}
    }
}
