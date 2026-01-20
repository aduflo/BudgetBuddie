//
//  BudgetSummaryViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class BudgetSummaryViewModel {
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
extension BudgetSummaryViewModel {
    func reloadData() {
        spendTrendsViewModel.reloadData()
        calendarViewModel.reloadData()
    }
    
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
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
