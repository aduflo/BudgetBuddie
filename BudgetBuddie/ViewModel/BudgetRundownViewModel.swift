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
    let settingsService: SettingsServiceable
    let spendRepository: SpendRepository
    let currencyFormatter: CurrencyFormattable
    private(set) var dailyTrendViewModel: BudgetTrendViewModel
    private(set) var mtdTrendViewModel: BudgetTrendViewModel
    private(set) var monthlyTrendViewModel: BudgetTrendViewModel
    
    // Constructors
    init(
        selectedDate: Date,
        settingsService: SettingsServiceable,
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable,
        dailyTrendViewModel: BudgetTrendViewModel = .mockDaily(),
        mtdTrendViewModel: BudgetTrendViewModel = .mockMtd(),
        monthlyTrendViewModel: BudgetTrendViewModel = .mockMonthly()
    ) {
        self.selectedDate = selectedDate
        self.settingsService = settingsService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        self.dailyTrendViewModel = dailyTrendViewModel
        self.mtdTrendViewModel = mtdTrendViewModel
        self.monthlyTrendViewModel = monthlyTrendViewModel
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
            currentSpend: currentSpend,
            maxSpend: dailyMaxSpend,
            settingsService: settingsService,
            currencyFormatter: currencyFormatter
        )
    }
    
    func mtdTrendViewModelBuilder() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: "Month-To-Date (MTD)",
            currentSpend: currentSpend,
            maxSpend: mtdMaxSpend,
            settingsService: settingsService,
            currencyFormatter: currencyFormatter
        )
    }
    
    func monthlyTrendViewModelBuilder() -> BudgetTrendViewModel {
        BudgetTrendViewModel(
            title: "Monthly",
            currentSpend: currentSpend,
            maxSpend: monthlyMaxSpend,
            settingsService: settingsService,
            currencyFormatter: currencyFormatter
        )
    }
    
    // Spend vars
    
    var currentSpend: Decimal {
        return 13.37 // FIXME: not foreal
    }
    
    var dailyMaxSpend: Decimal {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .day, in: .month, for: selectedDate)
        let daysInMonth = monthRange?.count ?? 0
        return monthlyMaxSpend / Decimal(daysInMonth)
    }
    
    var mtdMaxSpend: Decimal {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(in: TimeZone.current, from: selectedDate)
        let currentDay = dateComponents.day ?? 0
        let dailyMaxSpend = dailyMaxSpend
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
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
