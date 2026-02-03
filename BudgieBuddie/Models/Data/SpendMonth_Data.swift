//
//  SpendMonth_Data.swift
//  BudgieBuddie
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

// MARK: - Mocks
extension SpendMonth_Data {
    static func mock() -> SpendMonth_Data {
        SpendMonth_Data(
            id: UUID(),
            date: Date(),
            month: 02,
            year: 2026,
            spend: 13.37,
            allowance: 1337.00
        )
    }
}
