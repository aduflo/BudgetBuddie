//
//  SpendTrendsViewModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/30/25.
//

import Foundation

@Observable
class SpendTrendsViewModel {
    // Instance vars
    private let settingsService: SettingsServiceable
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    
    private(set) var dailyTrendViewModel: SpendTrendViewModel = placeholderDailyTrendViewModelBuilder()
    private(set) var mtdTrendViewModel: SpendTrendViewModel = placeholderMtdTrendViewModelBuilder()
    private(set) var monthlyTrendViewModel: SpendTrendViewModel = placeholderMonthlyTrendViewModelBuilder()
    
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
    
    func dailyTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: settingsService,
            currencyFormatter: currencyFormatter,
            title: Copy.daily,
            currentSpend: dailyCurrentSpend,
            maxSpend: dailyMaxSpend
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
    
    func mtdTrendViewModelBuilder() -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: settingsService,
            currencyFormatter: currencyFormatter,
            title: Copy.monthToDate,
            currentSpend: mtdCurrentSpend,
            maxSpend: mtdMaxSpend
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
        do {
            let items = try spendRepository.getItems(
                date: calendarService.selectedDate
            )
            return items.reduce(0, { $0 + $1.amount})
        } catch {
            return  0.0
        }
    }
    
    var mtdCurrentSpend: Decimal {
        cumulativeCurrentSpend
    }
    
    var monthlyCurrentSpend: Decimal {
        cumulativeCurrentSpend
    }
    
    var cumulativeCurrentSpend: Decimal {
        do {
            let monthDates = Calendar.current.monthDates(calendarService.selectedDate)
            let items = try spendRepository.getItems(
                dates: monthDates
            )
            return items.reduce(0, { $0 + $1.amount })
        } catch {
            return 0
        }
    }
    
    var dailyMaxSpend: Decimal {
        let days = Calendar.current.daysInMonthInDate(calendarService.selectedDate)
        return monthlyMaxSpend / Decimal(days)
    }
    
    var mtdMaxSpend: Decimal {
        let dailyMaxSpend = dailyMaxSpend
        let day = Calendar.current.dayInDate(calendarService.selectedDate)
        return dailyMaxSpend * Decimal(day)
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
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
