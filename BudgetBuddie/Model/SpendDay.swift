//
//  SpendDay.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class SpendDay {
    // Instance vars
    let id: UUID
    let date: Date
    let items: [SpendItem]
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        items: [SpendItem]
    ) {
        self.id = id
        self.date = date
        self.items = items
    }
}
