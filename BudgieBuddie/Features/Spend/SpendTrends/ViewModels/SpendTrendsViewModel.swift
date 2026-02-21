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
    
    private(set) var viewpoint: SpendTrendViewpoint
    private(set) var dailyTrendViewModel: SpendTrendViewModel
    private(set) var mtdTrendViewModel: SpendTrendViewModel
    private(set) var monthlyTrendViewModel: SpendTrendViewModel
    
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
        viewpoint = settingsService.defaultSpendTrendViewpoint
        dailyTrendViewModel = Self.placeholderTrendViewModelBuilder(title: Copy.daily)
        mtdTrendViewModel = Self.placeholderTrendViewModelBuilder(title: Copy.monthToDate)
        monthlyTrendViewModel = Self.placeholderTrendViewModelBuilder(title: Copy.monthly)
        reloadData()
    }
}

// MARK: Public interface
extension SpendTrendsViewModel {
    func useDefaultViewpoint() {
        viewpoint = settingsService.defaultSpendTrendViewpoint
    }
    
    func cycleViewpoint() {
        viewpoint.cycle()
    }
    
    func reloadData() {
        dailyTrendViewModel = dailyTrendViewModelBuilder()
        mtdTrendViewModel = mtdTrendViewModelBuilder()
        monthlyTrendViewModel = monthlyTrendViewModelBuilder()
    }
}

// MARK: Private interface
private extension SpendTrendsViewModel {
    // View model builders
    static func placeholderTrendViewModelBuilder(title: String) -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: SettingsService(userDefaults: UserDefaultsService()),
            currencyFormatter: CurrencyFormatter(),
            viewpoint: .spendAllowance,
            title: title,
            spend: 0,
            allowance: 0,
            remaining: 0
        )
    }
    
    func trendViewModelBuilder(
        title: String,
        spend: Decimal,
        allowance: Decimal,
        remaining: Decimal
    ) -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: settingsService,
            currencyFormatter: currencyFormatter,
            viewpoint: viewpoint,
            title: title,
            spend: spend,
            allowance: allowance,
            remaining: remaining
        )
    }
    
    func dailyTrendViewModelBuilder() -> SpendTrendViewModel {
        trendViewModelBuilder(
            title: Copy.daily,
            spend: dailySpend,
            allowance: dailyAllowance,
            remaining: dailyRemaining
        )
    }
    
    func mtdTrendViewModelBuilder() -> SpendTrendViewModel {
        trendViewModelBuilder(
            title: Copy.monthToDate,
            spend: mtdSpend,
            allowance: mtdAllowance,
            remaining: mtdRemaining
        )
    }
    
    func monthlyTrendViewModelBuilder() -> SpendTrendViewModel {
        trendViewModelBuilder(
            title: Copy.monthly,
            spend: monthlySpend,
            allowance: monthlyAllowance,
            remaining: monthlyRemaining
        )
    }
    
    // spend/allowance/remaining vars
    var dailySpend: Decimal {
        do {
            let items = try spendRepository.getItems(
                date: calendarService.selectedDate
            )
            return items.reduce(0, { $0 + $1.amount})
        } catch {
            return  0.0
        }
    }
    
    var mtdSpend: Decimal {
        do {
            let selectedDate = calendarService.selectedDate
            let monthDates = Calendar.current.monthDates(selectedDate)
            let day = Calendar.current.dayInDate(selectedDate)
            let monthDatesUpToSelectedDate = Array(monthDates.prefix(upTo: day))
            let items = try spendRepository.getItems(
                dates: monthDatesUpToSelectedDate
            )
            return items.reduce(0, { $0 + $1.amount })
        } catch {
            return 0
        }
    }
    
    var monthlySpend: Decimal {
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
    
    var dailyAllowance: Decimal {
        let days = Calendar.current.daysInMonthInDate(calendarService.selectedDate)
        return monthlyAllowance / Decimal(days)
    }
    
    var mtdAllowance: Decimal {
        let day = Calendar.current.dayInDate(calendarService.selectedDate)
        return dailyAllowance * Decimal(day)
    }
    
    var monthlyAllowance: Decimal {
        settingsService.monthlyAllowance
    }
    
    var dailyRemaining: Decimal {
        let remaining = dailyAllowance - dailySpend
        return min(remaining, monthlyRemaining)
    }
    
    var mtdRemaining: Decimal {
        let remaining = mtdAllowance - mtdSpend
        return min(remaining, monthlyRemaining)
    }
    
    var monthlyRemaining: Decimal {
        monthlyAllowance - monthlySpend
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
