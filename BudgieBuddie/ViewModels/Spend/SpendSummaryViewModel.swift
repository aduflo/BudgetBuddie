//
//  SpendSummaryViewModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class SpendSummaryViewModel {
    // Instance vars
    private let settingsService: SettingsServiceable
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    
    let spendTrendsViewModel: SpendTrendsViewModel
    let calendarViewModel: CalendarViewModel
    
    var onSettingsTapped: () -> () = {}
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        calendarService: CalendarServiceable,
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter
    ) {
        self.settingsService = settingsService
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        self.calendarViewModel = CalendarViewModel(
            calendarService: calendarService
        )
        self.spendTrendsViewModel = SpendTrendsViewModel(
            settingsService: settingsService,
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: currencyFormatter
        )
    }
}

// MARK: Public interface
extension SpendSummaryViewModel {    
    func settingsTapped() {
        onSettingsTapped()
    }
}

// MARK: - Mocks
extension SpendSummaryViewModel {
    static func mock() -> SpendSummaryViewModel {
        SpendSummaryViewModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
