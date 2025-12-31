//
//  SpendItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class SpendItemViewModel {
    // Instance vars
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepository
    let currencyFormatter: CurrencyFormattable
    
    let mode: Mode
    
    // Constructors
    init(
        calendarService: CalendarServiceable,
        spendRepository: SpendRepository,
        currencyFormatter: CurrencyFormattable,
        mode: Mode
    ) {
        self.calendarService = calendarService
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        self.mode = mode
    }
}

// MARK: Public interface
extension SpendItemViewModel {
    enum Mode {
        case new
        case edit(SpendItem)
    }
    
    var title: String {
        switch mode {
        case .new: Copy.newSpendItem
        case .edit: Copy.editSpendItem
        }
    }
    
    var amount: Decimal {
        switch mode {
        case .new: 0.0
        case .edit: 0.0 // FIXME: needs actual amount
        }
    }
    
    func setAmount(_ amount: Decimal) {
        print("\(String(describing: Self.self))-\(#function)-\(String(describing: amount))")
    }
    
    var description: String? {
        switch mode {
        case .new: nil
        case .edit: "Lorem ipsum" // FIXME: needs actual amount
        }
    }
    
    func setDescription(_ description: String?) {
        print("\(String(describing: Self.self))-\(#function)-\(String(describing: description))")
    }
    
    func saveTapped() {
        print("\(String(describing: Self.self))-\(#function)")
    }
}

// MARK: - Mocks
extension SpendItemViewModel {
    static func mock() -> SpendItemViewModel {
        SpendItemViewModel(
            calendarService: MockCalendarService(),
            spendRepository: SpendRepository(
                spendService: MockSpendService()
            ),
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
    }
}
