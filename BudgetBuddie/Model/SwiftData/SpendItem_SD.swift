//
//  SpendItem_SD.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/6/26.
//

import Foundation
import SwiftData

@Model
class SpendItem_SD {
    // Instance vars
    @Attribute(.unique) private(set) var id: UUID
    private(set) var amount: Decimal
    private(set) var note: String?
    private(set) var date: Date
    private(set) var createdAt: Date
    
    // Constructors
    init(
        id: UUID = UUID(),
        amount: Decimal,
        note: String? = nil,
        date: Date,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.amount = amount
        self.note = note
        self.date = date
        self.createdAt = createdAt
    }
}

// MARK: Public interface
extension SpendItem_SD {
    convenience init(
        spendItem: SpendItem
    ) {
        self.init(
            id: spendItem.id,
            amount: spendItem.amount,
            note: spendItem.note,
            date: spendItem.date,
            createdAt: spendItem.createdAt
        )
    }
    
    var spendItem: SpendItem {
        SpendItem(
            id: id,
            amount: amount,
            note: note,
            date: date,
            createdAt: createdAt
        )
    }
}
