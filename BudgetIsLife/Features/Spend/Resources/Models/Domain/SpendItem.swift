//
//  SpendItem.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class SpendItem {
    // Instance vars
    let id: UUID
    let dayId: UUID
    let amount: Decimal
    let note: String?
    let createdAt: Date // intended to be the date this object was initialized; diff from day.date
    
    // Constructors
    init(
        id: UUID,
        dayId: UUID,
        amount: Decimal,
        note: String?,
        createdAt: Date
    ) {
        self.id = id
        self.dayId = dayId
        self.amount = amount
        self.note = note
        self.createdAt = createdAt
    }
}

// MARK: Equatable
extension SpendItem: Equatable {
    static func == (lhs: SpendItem, rhs: SpendItem) -> Bool {
        lhs.id == rhs.id &&
        lhs.dayId == rhs.dayId &&
        lhs.amount == rhs.amount &&
        lhs.note == rhs.note &&
        lhs.createdAt == rhs.createdAt
    }
}

// MARK: Public interface
extension SpendItem {
    convenience init(
        dayId: UUID,
        amount: Decimal,
        note: String?
    ) {
        self.init(
            id: UUID(),
            dayId: dayId,
            amount: amount,
            note: note,
            createdAt: Date()
        )
    }
    
    func updatedCopy(
        amount: Decimal,
        note: String?
    ) -> SpendItem {
        SpendItem(
            id: id,
            dayId: dayId,
            amount: amount,
            note: note,
            createdAt: createdAt
        )
    }
}

// MARK: - Mocks
extension SpendItem {
    static func mock() -> SpendItem {
        SpendItem(
            dayId: UUID(),
            amount: 13.37,
            note: "Leet purchase"
        )
    }
}
