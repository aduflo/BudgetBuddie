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
    let spendRepository: SpendRepository
    let currencyFormatter: CurrencyFormattable
    
    let budgetSummaryViewModel: BudgetSummaryViewModel
    let spendViewModel: SpendViewModel
    
    @ObservationIgnored
    private(set) var spendItemToPresent: SpendItem? = nil
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        calendarService: CalendarServiceable,
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
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
        self.spendViewModel = SpendViewModel(
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: currencyFormatter
        )
    }
}

// MARK: Public interface
extension HomeViewModel {
    func setSpendItemToPresent(_ spendItem: SpendItem?) {
        spendItemToPresent = spendItem
    }
}


// MARK: - Mocks
extension HomeViewModel {
    static func mock() -> HomeViewModel {
        HomeViewModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: SpendRepository(
                spendService: MockSpendService(),
                calendarService: MockCalendarService()
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
