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
    private let settingsService: SettingsServiceable
    private let calendarService: CalendarServiceable
    private let currencyFormatter: CurrencyFormattable
    
    private(set) var dailyTrendViewModel: SpendTrendViewModel = placeholderDailyTrendViewModelBuilder()
    private(set) var mtdTrendViewModel: SpendTrendViewModel = placeholderMtdTrendViewModelBuilder()
    private(set) var monthlyTrendViewModel: SpendTrendViewModel = placeholderMonthlyTrendViewModelBuilder()
    
    // Constructors
    init(
        settingsService: SettingsServiceable,
        calendarService: CalendarServiceable,
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
    
    static func placeholderDailyTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: SettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.daily,
            currentSpend: 0,
            maxSpend: 0
        )
    }
    
    static func placeholderMtdTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: SettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.monthToDate,
            currentSpend: 0,
            maxSpend: 0
        )
    }
    
    static func placeholderMonthlyTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: SettingsService(),
            currencyFormatter: CurrencyFormatter(),
            title: Copy.monthly,
            currentSpend: 0,
            maxSpend: 0
        )
    }
    
    func dailyTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: settingsService,
            currencyFormatter: currencyFormatter,
            title: Copy.daily,
            currentSpend: dailyCurrentSpend,
            maxSpend: dailyMaxSpend
        )
    }
    
    func mtdTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: settingsService,
            currencyFormatter: currencyFormatter,
            title: Copy.monthToDate,
            currentSpend: mtdCurrentSpend,
            maxSpend: mtdMaxSpend
        )
    }
    
    func monthlyTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: settingsService,
            currencyFormatter: currencyFormatter,
            title: Copy.monthly,
            currentSpend: monthlyCurrentSpend,
            maxSpend: monthlyMaxSpend
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
            calendarService: MockCalendarService(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
