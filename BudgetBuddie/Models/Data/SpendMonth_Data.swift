//
//  SpendMonth_Data.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation

class SpendMonth_Data {
    // Instance vars
    let id: UUID
    let date: Date
    let month: Int
    let year: Int
    let spend: Decimal
    let allowance: Decimal
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        month: Int,
        year: Int,
        spend: Decimal,
        allowance: Decimal
    ) {
        self.id = id
        self.date = date
        self.month = month
        self.year = year
        self.spend = spend
        self.allowance = allowance
    }
}
