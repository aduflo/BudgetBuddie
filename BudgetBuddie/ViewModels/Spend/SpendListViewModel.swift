//
//  SpendListViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class SpendListViewModel {
    // Instance vars
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    
    private(set) var title: String = ""
    private(set) var listItemViewModels: [SpendListItemViewModel] = []
    private(set) var error: Error? = nil
    
    var onNewSpendItemTapped: () -> () = {}
    var onSpendItemTapped: (SpendItem) -> () = { _ in }
    
    init(
        calendarService: CalendarServiceable,
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter
    ) {
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension SpendListViewModel {
    func reloadData() {
        title = calendarService.selectedDate.monthDayString
        
        do {
            error = nil
            listItemViewModels = try listItemViewModelsBuilder()
        } catch {
            self.error = error
            listItemViewModels = []
        }
    }
    
    func newSpendItemTapped() {
        onNewSpendItemTapped()
    }
    
    func spendItemTapped(_ spendItem: SpendItem) {
        onSpendItemTapped(spendItem)
    }
}

// MARK: Private interface
private extension SpendListViewModel {
    func listItemViewModelsBuilder() throws -> [SpendListItemViewModel] {
        try spendRepository.getItems(
            date: calendarService.selectedDate
        ).sorted(by: { left, right in
            left.createdAt > right.createdAt // we want latest item first
        }).map {
            SpendListItemViewModel(
                currencyFormatter: currencyFormatter,
                spendItem: $0
            )
        }
    }
}

// MARK: - Mocks
extension SpendListViewModel {
    static func mock() -> SpendListViewModel {
        SpendListViewModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
