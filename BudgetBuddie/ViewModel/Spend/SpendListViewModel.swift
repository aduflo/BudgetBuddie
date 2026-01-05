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
    
    private(set) var items: [SpendListItemViewModel] = []
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
            items = try spendRepository.getSpendItems(
                date: calendarService.selectedDate
            ).map {
                SpendListItemViewModel(
                    currencyFormatter: currencyFormatter,
                    spendItem: $0
                )
            }.sorted(by: { left, right in
                left.spendItem.createdAt > right.spendItem.createdAt // we want latest item first
            })
        } catch {
            spendStoreError = error as? SpendStoreError
            items = []
        }
    }
    
    func spendItemTapped(_ spendItem: SpendItem) {
        onSpendItemTapped(spendItem)
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
