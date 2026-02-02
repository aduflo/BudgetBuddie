//
//  SpendItemScreenModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

@Observable
class SpendItemScreenModel {
    // Instance vars
    private let calendarService: CalendarServiceable
    private let spendRepository: SpendRepositable
    let currencyFormatter: CurrencyFormatter
    let mode: Mode
    
    // Display instance vars
    private(set) var title: String = ""
    private(set) var amount: Decimal = 0.0
    private(set) var note: String = ""
    private(set) var requiredFieldWarningText: AttributedString? = nil
    private(set) var error: Error? = nil
    
    // Constructors
    init(
        calendarService: CalendarServiceable,
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter,
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
        case .new: Copy.newSpendItemTitle
        case .existing: Copy.editSpendItemTitle
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
extension SpendItemScreenModel {
    enum Mode {
        case new
        case existing(SpendItem)
    }
    
    func setAmount(_ amount: Decimal?) {
        self.amount = amount ?? 0.0
    }
    
    func setNote(_ note: String) {
        self.note = note
    }
    
    func deleteTapped() -> Bool {
        error = nil
        
        guard case .existing(let spendItem) = mode else {
            return false
        }
        
        do {
            try spendRepository.deleteItem(spendItem)
        } catch {
            self.error = error
            return false
        }
        return true
    }
    
    /// - Returns: Flag value indicating if save succeeded, or not.
    func saveTapped() -> Bool {
        requiredFieldWarningText = nil
        self.error = nil
        
        guard amount > 0.0 else {
            requiredFieldWarningText = Copy.requiredFieldWarningAmount
            return false
        }
        
        let amount = amount
        let note = note.isEmpty ? nil : note
        do {
            switch mode {
            case .new:
                let day = try spendRepository.getDay(
                    date: calendarService.selectedDate
                )
                try spendRepository.saveItem(
                    SpendItem(
                        dayId: day.id,
                        amount: amount,
                        note: note
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
            self.error = error
            return false
        }
        return true
    }
}

// MARK: - Mocks
extension SpendItemScreenModel {
    static func mock() -> SpendItemScreenModel {
        SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
    }
}
