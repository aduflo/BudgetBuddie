//
//  HomeScreenModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class HomeScreenModel {
    // Instance vars
    let settingsService: SettingsServiceable
    let calendarService: CalendarServiceable
    let spendRepository: SpendRepositable
    let currencyFormatter: CurrencyFormatter
    
    private(set) var spendSummaryViewModel: SpendSummaryViewModel
    private(set) var spendListViewModel: SpendListViewModel
    
    @ObservationIgnored
    private(set) var spendItemToPresent: SpendItem? = nil
    @ObservationIgnored
    private(set) var spendMonthSummaryDateToPresent: Date? = nil
    
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
        self.spendSummaryViewModel = SpendSummaryViewModel(
            settingsService: settingsService,
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: currencyFormatter
        )
        self.spendListViewModel = SpendListViewModel(
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: currencyFormatter
        )
    }
}

// MARK: Public interface
extension HomeScreenModel {
    var didOnboardOnce: Bool {
        UserDefaults.standard.bool(
            forKey: UserDefaults.Key.App.didOnboardOnce
        )
    }
    
    func reloadData() {
        // assign new values
        // so that the view hierarchy gets entirely redrawn
        // vs just changing out some underlying values via instance defined reloadData() funcs
        // this is to guarantee certain expectations
        // eg. the CalendarView being scrolled to the correct day
        // and reduce the potential for state malformation
        self.spendSummaryViewModel = SpendSummaryViewModel(
            settingsService: settingsService,
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: currencyFormatter
        )
        self.spendListViewModel = SpendListViewModel(
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: currencyFormatter
        )
    }
    
    func setSpendItemToPresent(_ spendItem: SpendItem?) {
        spendItemToPresent = spendItem
    }
    
    func setSpendMonthSummaryDateToPresent(date: Date) {
        spendMonthSummaryDateToPresent = date
    }
}


// MARK: - Mocks
extension HomeScreenModel {
    static func mock() -> HomeScreenModel {
        HomeScreenModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
