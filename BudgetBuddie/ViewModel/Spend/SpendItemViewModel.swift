//
//  SpendItemViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

@Observable
class SpendItemViewModel {
    // Instance vars
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepository
    let currencyFormatter: CurrencyFormattable
    
    let mode: Mode
    
    // Display instance vars
    private(set) var title: String = ""
    private(set) var amount: Decimal = 0.0
    private(set) var description: String = ""
    private(set) var requiredFieldWarningText: AttributedString? = nil
    
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
        setInitialDisplayValues()
    }
    
    func setInitialDisplayValues() {
        title = switch mode {
        case .new: Copy.newSpendItem
        case .existing: Copy.editSpendItem
        }
        amount = switch mode {
        case .new: 0.0
        case .existing(let spendItem): spendItem.amount
        }
        description = switch mode {
        case .new: ""
        case .existing(let spendItem): spendItem.description ?? ""
        }
    }
}

// MARK: Public interface
extension SpendItemViewModel {
    enum Mode {
        case new
        case existing(SpendItem)
    }
    
    func setAmount(_ amount: Decimal) {
        print("\(String(describing: Self.self))-\(#function)-\(String(describing: amount))")
        self.amount = amount
    }
    
    func setDescription(_ description: String) {
        print("\(String(describing: Self.self))-\(#function)-\(String(describing: description))")
        self.description = description
    }
    
    func saveTapped() {
        print("\(String(describing: Self.self))-\(#function)")
        guard amount > 0.0 else {
            requiredFieldWarningText = Copy.requiredFieldWarningAmount
            return
        }
        requiredFieldWarningText = nil
        
        // TODO: save SpendItem
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
