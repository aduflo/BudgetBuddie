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
            items = try spendRepository.getSpendItems(
                date: calendarService.selectedDate
            ).map {
                SpendListItemViewModel(
                    currencyFormatter: currencyFormatter,
                    spendItem: $0
                )
            }
        } catch {
            print("\(String(describing: Self.self))-\(#function) error: \(error)")
            // TODO: handle error
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
