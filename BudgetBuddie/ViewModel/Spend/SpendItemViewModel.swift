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
    private(set) var note: String = ""
    private(set) var requiredFieldWarningText: AttributedString? = nil
    private(set) var spendStoreError: SpendStoreError? = nil
    
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
        note = switch mode {
        case .new: ""
        case .existing(let spendItem): spendItem.note ?? ""
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
        self.amount = amount
    }
    
    func setNote(_ note: String) {
        self.note = note
    }
    
    func deleteTapped() -> Bool {
        spendStoreError = nil
        
        guard case .existing(let spendItem) = mode else {
            return false
        }
        
        do {
            try spendRepository.deleteItem(spendItem)
        } catch {
            spendStoreError = error as? SpendStoreError
            return false
        }
        return true
    }
    
    /// - Returns: Flag value indicating if save succeeded, or not.
    func saveTapped() -> Bool {
        requiredFieldWarningText = nil
        spendStoreError = nil
        
        guard amount > 0.0 else {
            requiredFieldWarningText = Copy.requiredFieldWarningAmount
            return false
        }
        
        let amount = amount
        let note = note.isEmpty ? nil : note
        do {
            switch mode {
            case .new:
                try spendRepository.saveItem(
                    SpendItem(
                        amount: amount,
                        note: note,
                        date: calendarService.selectedDate
                    )
                )
            case .existing(let spendItem):
                try spendRepository.saveItem(
                    spendItem.updatedCopy(
                        amount: amount,
                        note: note
                    )
                )
            }
        } catch {
            spendStoreError = error as? SpendStoreError
            return false
        }
        return true
    }
}

// MARK: - Mocks
extension SpendItemViewModel {
    static func mock() -> SpendItemViewModel {
        SpendItemViewModel(
            calendarService: MockCalendarService(),
            spendRepository: SpendRepository(
                spendStore: MockSpendStore(),
            ),
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
    }
}
