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
    let spend: Decimal
    let allowance: Decimal
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        spend: Decimal,
        allowance: Decimal
    ) {
        self.id = id
        self.date = date
        self.spend = spend
        self.allowance = allowance
    }
}

// MARK: Public interface
extension SpendMonth {
    convenience init(
        date: Date,
        spend: Decimal,
        allowance: Decimal
    ) {
        self.init(
            id: UUID(),
            date: date,
            spend: spend,
            allowance: allowance
        )
    }
}

// MARK: - Mocks
extension SpendMonth {
    static func mock() -> SpendMonth {
        SpendMonth(
            date: Date(),
            spend: 9001.00,
            allowance: 9000.00
        )
    }
}
