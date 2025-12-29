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
    let calendarViewModel: CalendarViewModel
    let spendListViewModel: SpendListViewModel
    
    private let calendarService: CalenderServiceable
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable
    
    var onNewSpendItemTapped: () -> () = {}
    
    // Constructors
    init(
        calendarViewModel: CalendarViewModel,
        spendListViewModel: SpendListViewModel,
        calendarService: CalenderServiceable,
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
    ) {
        self.calendarViewModel = calendarViewModel
        self.spendListViewModel = spendListViewModel
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        self.onNewSpendItemTapped = onNewSpendItemTapped
    }
}

// MARK: Public interface
extension SpendViewModel {
    func reloadData() {
        print("\(String(describing: Self.self))-\(#function)")
    }
    
    func newSpendItemTapped() {
        onNewSpendItemTapped()
    }
    
    // View model builders
    func buildNewSpendItemViewModel() -> NewSpendItemViewModel {
        NewSpendItemViewModel(
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: currencyFormatter
        )
    }
}

// MARK: - Mocks
extension SpendViewModel {
    static func mock() -> SpendViewModel {
        SpendViewModel(
            calendarViewModel: .mock(),
            spendListViewModel: .mock(),
            calendarService: MockCalenderService(),
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
