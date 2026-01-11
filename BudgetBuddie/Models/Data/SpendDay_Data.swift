//
//  SpendDay_Data.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

class SpendDay_Data {
    // Instance vars
    let id: UUID
    let date: Date
    let items: [SpendItem_Data]
    let key: String?
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        items: [SpendItem_Data],
        key: String?
    ) {
        self.id = id
        self.date = date
        self.items = items
        self.key = key
    }
}
