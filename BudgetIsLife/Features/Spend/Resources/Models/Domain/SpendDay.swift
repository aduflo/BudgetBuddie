//
//  SpendDay.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class SpendDay {
    // Instance vars
    let id: UUID
    let date: Date
    let items: [SpendItem]
    let isCommitted: Bool
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        items: [SpendItem],
        isCommitted: Bool
    ) {
        self.id = id
        self.date = date
        self.items = items
        self.isCommitted = isCommitted
    }
}

// MARK: Public interface
extension SpendDay {
    convenience init(
        date: Date,
        items: [SpendItem],
        isCommitted: Bool
    ) {
        self.init(
            id: UUID(),
            date: date,
            items: items,
            isCommitted: isCommitted
        )
    }
}

// MARK: - Mocks
extension SpendDay {
    static func mock() -> SpendDay {
        SpendDay(
            date: Date(),
            items: [],
            isCommitted: false
        )
    }
}
