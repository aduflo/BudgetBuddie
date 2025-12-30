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
    private let spendRepository: SpendRepository
    private let currencyFormatter: CurrencyFormattable

    let spendListViewModel: SpendListViewModel = .mock()
    
    var onNewSpendItemTapped: () -> () = {}
    
    // Constructors
    init(
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable
    ) {
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
        print("\(String(describing: Self.self))-\(#function)")
    }
    
    func newSpendItemTapped() {
        onNewSpendItemTapped()
    }
}

// MARK: - Mocks
extension SpendViewModel {
    static func mock() -> SpendViewModel {
        SpendViewModel(
            spendRepository: SpendRepository(spendService: MockSpendService()),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
