//
//  SpendMonth.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation

class SpendMonth {
    // Instance vars
    let id: UUID
    // TODO: persist date: Date instead of month+year; fix up everything and test
    let month: Int
    let year: Int
    let spend: Decimal
    let allowance: Decimal
    
    // Constructors
    init(
        id: UUID,
        month: Int,
        year: Int,
        spend: Decimal,
        allowance: Decimal
    ) {
        self.id = id
        self.month = month
        self.year = year
        self.spend = spend
        self.allowance = allowance
    }
}

// MARK: Public interface
extension SpendMonth {
    convenience init(
        month: Int,
        year: Int,
        spend: Decimal,
        allowance: Decimal
    ) {
        self.init(
            id: UUID(),
            month: month,
            year: year,
            spend: spend,
            allowance: allowance
        )
    }
}

// MARK: - Mocks
extension SpendMonth {
    static func mock() -> SpendMonth {
        SpendMonth(
            month: 01,
            year: 2026,
            spend: 9001.00,
            allowance: 9000.00
        )
    }
}
