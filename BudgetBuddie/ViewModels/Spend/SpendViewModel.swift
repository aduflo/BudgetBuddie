//
//  SpendViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

@Observable
class SpendViewModel {
    // Instance vars
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter

    let spendListViewModel: SpendListViewModel
    var onNewSpendItemTapped: () -> () = {}
    
    private(set) var title: String = ""    
    
    // Constructors
    init(
        calendarService: CalendarServiceable,
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter
    ) {
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        self.spendListViewModel = SpendListViewModel(
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: currencyFormatter
        )
    }
}

// MARK: Public interface
extension SpendViewModel {
    func reloadData() {
        generateTitle()
    }
    
    func newSpendItemTapped() {
        onNewSpendItemTapped()
    }
}

// MARK: - Private interface
private extension SpendViewModel {
    func generateTitle() {
        title = calendarService.selectedDate.monthDayString
    }
}

// MARK: - Mocks
extension SpendViewModel {
    static func mock() -> SpendViewModel {
        SpendViewModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
