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
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable
    
    private(set) var listItemViewModels: [SpendListItemViewModel] = []
    private(set) var spendStoreError: SpendStoreError? = nil
    
    var onSpendItemTapped: (SpendItem) -> () = { _ in }
    
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

// MARK: Public interface
extension SpendListViewModel {
    func reloadData() {
        do {
            spendStoreError = nil
            listItemViewModels = try listItemViewModelsBuilder()
        } catch {
            spendStoreError = error as? SpendStoreError
            listItemViewModels = []
        }
    }
    
    func spendItemTapped(_ spendItem: SpendItem) {
        onSpendItemTapped(spendItem)
    }
}

// MARK: Private interface
private extension SpendListViewModel {
    func listItemViewModelsBuilder() throws -> [SpendListItemViewModel] {
        try spendRepository.getSpendItems(
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
        let currencyFormatter = CurrencyFormatter()
        return SpendListViewModel(
            calendarService: MockCalendarService(),
            spendRepository: SpendRepository(
                spendStore: MockSpendStore()
            ),
            currencyFormatter: currencyFormatter
        )
    }
}
