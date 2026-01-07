//
//  SpendItem.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class SpendItem {
    // Instance vars
    let id: UUID
    let amount: Decimal
    let note: String?
    let date: Date
    let createdAt: Date
    
    // Constructors
    init(
        id: UUID,
        amount: Decimal,
        note: String?,
        date: Date,
        createdAt: Date
    ) {
        self.id = id
        self.amount = amount
        self.note = note
        self.date = date
        self.createdAt = createdAt
    }
}

// MARK: Public interface
extension SpendItem {
    convenience init(
        amount: Decimal,
        note: String?,
        date: Date
    ) {
        self.init(
            id: UUID(),
            amount: amount,
            note: note,
            date: date,
            createdAt: Date()
        )
    }
    
    func updatedCopy(
        amount: Decimal,
        note: String?
    ) -> SpendItem {
        SpendItem(
            id: id,
            amount: amount,
            note: note,
            date: date,
            createdAt: createdAt
        )
    }
}
