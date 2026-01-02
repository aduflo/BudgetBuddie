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
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable

    private(set) var title: String = ""
    
    var onNewSpendItemTapped: () -> () = {}
    
    let spendListViewModel: SpendListViewModel = .mock()
    
    // Constructors
    init(
        calendarService: CalendarServiceable,
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
    ) {
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
//        self.spendListViewModel = SpendListViewModel( // TODO: use when persistence is ready
//            spendRepository: spendRepository,
//            currencyFormatter: currencyFormatter
//        )
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
        title = calendarService.selectedDate.formatted(.dateTime.day(.twoDigits).month(.twoDigits))
    }
}

// MARK: - Mocks
extension SpendViewModel {
    static func mock() -> SpendViewModel {
        SpendViewModel(
            calendarService: MockCalendarService(),
            spendRepository: SpendRepository(spendService: MockSpendService()),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
