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
