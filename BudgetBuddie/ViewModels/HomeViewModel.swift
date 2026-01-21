//
//  HomeViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class HomeViewModel {
    // Instance vars
    let settingsService: SettingsServiceable
    let calendarService: CalendarServiceable
    let spendRepository: SpendRepositable
    let currencyFormatter: CurrencyFormatter
    
    let budgetSummaryViewModel: BudgetSummaryViewModel
    let spendListViewModel: SpendListViewModel
    
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
        self.budgetSummaryViewModel = BudgetSummaryViewModel(
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
extension HomeViewModel {
    func reloadData() {
        budgetSummaryViewModel.reloadData()
        spendListViewModel.reloadData()
    }
    
    func setSpendItemToPresent(_ spendItem: SpendItem?) {
        spendItemToPresent = spendItem
    }
    
    func setSpendMonthSummaryDateToPresent(date: Date) {
        spendMonthSummaryDateToPresent = date
    }
}


// MARK: - Mocks
extension HomeViewModel {
    static func mock() -> HomeViewModel {
        HomeViewModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
