//
//  NewSpendItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

struct NewSpendItemViewModel {
    // Instance vars
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable
    
    // Constructors
    init(
        calendarService: CalendarServiceable,
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
    ) {
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: - Mocks
extension NewSpendItemViewModel {
    static func mock() -> NewSpendItemViewModel {
        NewSpendItemViewModel(
            calendarService: MockCalendarService(),
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
