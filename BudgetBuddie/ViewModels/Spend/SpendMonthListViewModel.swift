//
//  SpendMonthListViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import Foundation

@Observable
class SpendMonthListViewModel {
    // Instance vars
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    
    private(set) var listItemViewModels: [SpendMonthListItemViewModel] = []
    private(set) var error: Error? = nil
    
    // Constructors
    init(
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter
    ) {
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
    }
}

// MARK: Public interface
extension SpendMonthListViewModel {
    func reloadData() {
        do {
            error = nil
            listItemViewModels = try listItemViewModelsBuilder()
            print("")
        } catch {
            self.error = error
            listItemViewModels = []
        }
    }
}

// MARK: Private interface
private extension SpendMonthListViewModel {
    func listItemViewModelsBuilder() throws -> [SpendMonthListItemViewModel] {
        try spendRepository.getAllMonths().map {
            SpendMonthListItemViewModel(
                currencyFormatter: currencyFormatter,
                spendMonth: $0
            )
        }
    }
}

// MARK: - Mocks
extension SpendMonthListViewModel {
    static func mock() -> SpendMonthListViewModel {
        SpendMonthListViewModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
