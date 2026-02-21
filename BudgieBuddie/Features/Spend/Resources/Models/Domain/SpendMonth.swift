//
//  SpendMonth.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation

class SpendMonth {
    // Instance vars
    let id: UUID
    let date: Date
    let dayIds: [UUID]
    let allowance: Decimal
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        dayIds: [UUID],
        allowance: Decimal
    ) {
        self.id = id
        self.date = date
        self.dayIds = dayIds
        self.allowance = allowance
    }
}

// MARK: Public interface
extension SpendMonth {
    convenience init(
        date: Date,
        dayIds: [UUID],
        allowance: Decimal
    ) {
        self.init(
            id: UUID(),
            date: date,
            dayIds: dayIds,
            allowance: allowance
        )
    }
}

// MARK: - Mocks
extension SpendMonth {
    static func mock() -> SpendMonth {
        SpendMonth(
            date: Date(),
            dayIds: [UUID()],
            allowance: 9000.00
        )
    }
}
