//
//  BudgetSummaryViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class BudgetSummaryViewModel { // TODO: consider rename
    // Instance vars
    private let settingsService: SettingsServiceable
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable
    
    let spendTrendsViewModel: SpendTrendsViewModel
    let calendarViewModel: CalendarViewModel
    
    var onSettingsTapped: () -> () = {}
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        calendarService: CalendarServiceable,
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
    ) {
        self.calendarViewModel = CalendarViewModel(
            calendarService: calendarService
        )
        self.spendTrendsViewModel = SpendTrendsViewModel(
            settingsService: settingsService,
            calendarService: calendarService,
            currencyFormatter: currencyFormatter
        )
        self.settingsService = settingsService
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension BudgetSummaryViewModel {    
    func settingsTapped() {
        onSettingsTapped()
    }
}

// MARK: - Mocks
extension BudgetSummaryViewModel {
    static func mock() -> BudgetSummaryViewModel {
        BudgetSummaryViewModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
