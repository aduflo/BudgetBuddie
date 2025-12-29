//
//  BudgetRundownViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class BudgetRundownViewModel {
    // Instance vars
    let selectedDate: Date
    private(set) var dailyTrendViewModel: BudgetTrendViewModel
    private(set) var mtdTrendViewModel: BudgetTrendViewModel
    private(set) var monthlyTrendViewModel: BudgetTrendViewModel
    
    let settingsService: SettingsServiceable
    let calendarService: CalenderServiceable
    let spendRepository: SpendRepository
    let currencyFormatter: CurrencyFormattable
    
    // Constructors
    init(
        selectedDate: Date,
        dailyTrendViewModel: BudgetTrendViewModel = .mockDaily(), // TODO: remove mock
        mtdTrendViewModel: BudgetTrendViewModel = .mockMtd(), // TODO: remove mock
        monthlyTrendViewModel: BudgetTrendViewModel = .mockMonthly(), // TODO: remove mock
        settingsService: SettingsServiceable,
        calendarService: CalenderServiceable,
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
    ) {
        self.selectedDate = selectedDate
        self.dailyTrendViewModel = dailyTrendViewModel
        self.mtdTrendViewModel = mtdTrendViewModel
        self.monthlyTrendViewModel = monthlyTrendViewModel
        self.settingsService = settingsService
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension BudgetRundownViewModel {
    func reloadData() {
        print("\(String(describing: Self.self))-\(#function)")
        
        dailyTrendViewModel = dailyTrendViewModelBuilder()
        mtdTrendViewModel = mtdTrendViewModelBuilder()
        monthlyTrendViewModel = monthlyTrendViewModelBuilder()
    }
    
    var displayDate: String {
        selectedDate.formatted(
            date: .long,
            time: .omitted
        )
    }
    
    func postNotificationSettingsTapped() {
        NotificationCenter.default.post(.SettingsTapped)
    }
}

// MARK: Private interface
private extension BudgetRundownViewModel {
    // View model builders
    
    func dailyTrendViewModelBuilder() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: "Daily",
            currentSpend: dailyCurrentSpend,
            maxSpend: dailyMaxSpend,
            settingsService: settingsService,
            currencyFormatter: currencyFormatter
        )
    }
    
    func mtdTrendViewModelBuilder() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: "Month-To-Date (MTD)",
            currentSpend: mtdCurrentSpend,
            maxSpend: mtdMaxSpend,
            settingsService: settingsService,
            currencyFormatter: currencyFormatter
        )
    }
    
    func monthlyTrendViewModelBuilder() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: "Monthly",
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
        let daysInMonth = calendarService.daysInMonth(selectedDate)
        return monthlyMaxSpend / Decimal(daysInMonth)
    }
    
    var mtdMaxSpend: Decimal {
        let dailyMaxSpend = dailyMaxSpend
        let currentDay = calendarService.currentMonthDay(selectedDate)
        return dailyMaxSpend * Decimal(currentDay)
    }
    
    var monthlyMaxSpend: Decimal {
        settingsService.monthlyAllowance
    }
}

// MARK: - Mocks
extension BudgetRundownViewModel {
    static func mock() -> BudgetRundownViewModel {
        BudgetRundownViewModel(
            selectedDate: Date(),
            settingsService: MockSettingsService(),
            calendarService: MockCalenderService(),
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
