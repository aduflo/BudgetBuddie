//
//  SpendItem_Data.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

class SpendItem_Data {
    // Instance vars
    let id: UUID
    let dayId: UUID
    let amount: Decimal
    let note: String?
    let createdAt: Date
    
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

// MARK: - Mocks
extension SpendItem_Data {
    static func mock() -> SpendItem_Data {
        SpendItem_Data(
            id: UUID(),
            dayId: UUID(),
            amount: 13.37,
            note: "leet",
            createdAt: Date()
        )
    }
}
