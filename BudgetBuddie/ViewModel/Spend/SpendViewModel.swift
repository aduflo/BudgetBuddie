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
    let spendListViewModel: SpendListViewModel
    let calendarViewModel: CalendarViewModel
    
    var onNewSpendItemTapped: () -> () = {}
    
    // Constructors
    init(
        spendListViewModel: SpendListViewModel,
        calendarViewModel: CalendarViewModel
    ) {
        self.spendListViewModel = spendListViewModel
        self.calendarViewModel = calendarViewModel
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
            spendListViewModel: .mock(),
            calendarViewModel: .mock()
        )
    }
}
