//
//  SpendTrendsViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/30/25.
//

import Foundation

@Observable
class SpendTrendsViewModel {
    // Instance vars
    private(set) var dailyTrendViewModel: SpendTrendViewModel = .emptyDaily()
    private(set) var mtdTrendViewModel: SpendTrendViewModel = .emptyMtd()
    private(set) var monthlyTrendViewModel: SpendTrendViewModel = .emptyMonthly()
    
    private let settingsService: SettingsServiceable
    private let calendarService: CalenderServiceable
    private let currencyFormatter: CurrencyFormattable
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        calendarService: CalenderServiceable,
        currencyFormatter: CurrencyFormattable
    ) {
        self.settingsService = settingsService
        self.calendarService = calendarService
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension SpendTrendsViewModel {
    func reloadData() {
        dailyTrendViewModel = dailyTrendViewModelBuilder()
        mtdTrendViewModel = mtdTrendViewModelBuilder()
        monthlyTrendViewModel = monthlyTrendViewModelBuilder()
    }
}

// MARK: Private interface
private extension SpendTrendsViewModel {
    // View model builders
    
    func dailyTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            title: Copy.daily,
            currentSpend: dailyCurrentSpend,
            maxSpend: dailyMaxSpend,
            settingsService: settingsService,
            currencyFormatter: currencyFormatter
        )
    }
    
    func mtdTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            title: Copy.monthToDate,
            currentSpend: mtdCurrentSpend,
            maxSpend: mtdMaxSpend,
            settingsService: settingsService,
            currencyFormatter: currencyFormatter
        )
    }
    
    func monthlyTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            title: Copy.monthly,
            currentSpend: monthlyCurrentSpend,
            maxSpend: monthlyMaxSpend,
            settingsService: settingsService,
            currencyFormatter: currencyFormatter
        )
    }
    
    // Spend vars
    
    var dailyCurrentSpend: Decimal {
        return 13.37 // FIXME: not foreal
    }
    
    var mtdCurrentSpend: Decimal {
        return 90.01 // FIXME: not real
    }
    
    var monthlyCurrentSpend: Decimal {
        return 90.01 // FIXME: not real
    }
    
    var dailyMaxSpend: Decimal {
        let daysInMonth = calendarService.daysInMonth(calendarService.selectedDate)
        return monthlyMaxSpend / Decimal(daysInMonth)
    }
    
    var mtdMaxSpend: Decimal {
        let dailyMaxSpend = dailyMaxSpend
        let currentDay = calendarService.currentMonthDay(calendarService.selectedDate)
        return dailyMaxSpend * Decimal(currentDay)
    }
    
    var monthlyMaxSpend: Decimal {
        settingsService.monthlyAllowance
    }
}

// MARK: Mocks
extension SpendTrendsViewModel {
    static func mock() -> SpendTrendsViewModel {
        SpendTrendsViewModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalenderService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
