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
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable
    
    private(set) var dailyTrendViewModel: SpendTrendViewModel = placeholderDailyTrendViewModelBuilder()
    private(set) var mtdTrendViewModel: SpendTrendViewModel = placeholderMtdTrendViewModelBuilder()
    private(set) var monthlyTrendViewModel: SpendTrendViewModel = placeholderMonthlyTrendViewModelBuilder()
    
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
        do {
            let items = try spendRepository.getSpendItems(
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
            let items = try spendRepository.getAllSpendItems(
                date: calendarService.selectedDate
            )
            return items.reduce(0, { $0 + $1.amount })
        } catch {
            return 0
        }
    }
    
    var dailyMaxSpend: Decimal {
        let daysInMonth = CalendarService.daysInMonth(calendarService.selectedDate)
        return monthlyMaxSpend / Decimal(daysInMonth)
    }
    
    var mtdMaxSpend: Decimal {
        let dailyMaxSpend = dailyMaxSpend
        let dayInMonth = CalendarService.dayInMonth(calendarService.selectedDate)
        return dailyMaxSpend * Decimal(dayInMonth)
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
            spendRepository: SpendRepository(
                spendStore: MockSpendStore()
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
