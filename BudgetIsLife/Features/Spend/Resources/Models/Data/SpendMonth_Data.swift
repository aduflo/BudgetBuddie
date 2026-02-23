//
//  SpendMonth_Data.swift
//  BudgetIsLife
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
    let dayIds: [UUID]
    let allowance: Decimal
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        month: Int,
        year: Int,
        dayIds: [UUID],
        allowance: Decimal
    ) {
        self.id = id
        self.date = date
        self.month = month
        self.year = year
        self.dayIds = dayIds
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
            dayIds: [UUID()],
            allowance: 1337.00
        )
    }
}
