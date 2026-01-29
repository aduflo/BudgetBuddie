//
//  SpendDay.swift
//  BirdsEye
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

// MARK: Public interface
extension SpendDay {
    convenience init(
        date: Date,
        items: [SpendItem]
    ) {
        self.init(
            id: UUID(),
            date: date,
            items: items
        )
    }
}

// MARK: - Mocks
extension SpendDay {
    static func mock() -> SpendDay {
        SpendDay(
            date: Date(),
            items: []
        )
    }
}
