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
    let description: String?
    let date: Date
    let createdAt: Date
    
    // Constructors
    init(
        id: UUID = UUID(),
        amount: Decimal,
        description: String?,
        date: Date,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.amount = amount
        self.description = description
        self.date = date
        self.createdAt = createdAt
    }
}
