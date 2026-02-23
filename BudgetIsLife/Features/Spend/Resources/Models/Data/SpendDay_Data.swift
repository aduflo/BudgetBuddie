//
//  SpendDay_Data.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

class SpendDay_Data {
    // Instance vars
    let id: UUID
    let date: Date
    let items: [SpendItem_Data]
    let isCommitted: Bool
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        items: [SpendItem_Data],
        isCommitted: Bool
    ) {
        self.id = id
        self.date = date
        self.items = items
        self.isCommitted = isCommitted
    }
}

// MARK: - Mocks
extension SpendDay_Data {
    static func mock() -> SpendDay_Data {
        let dayId = UUID()
        let day = SpendDay_Data(
            id: dayId,
            date: Date(),
            items: [
                SpendItem_Data(
                    id: UUID(),
                    dayId: dayId,
                    amount: 12.0,
                    note: nil,
                    createdAt: Date()
                )
            ],
            isCommitted: false
        )
        return day
    }
}
