//
//  SpendDay_SD.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/6/26.
//

import Foundation
import SwiftData

@Model
class SpendDay_SD {
    // Instance vars
    @Attribute(.unique) private(set) var id: UUID
    private(set) var date: Date
    private(set) var key: String
    @Relationship(deleteRule: .cascade) private(set) var items: [SpendItem_SD]
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        key: String,
        items: [SpendItem_SD]
    ) {
        self.id = id
        self.date = date
        self.key = key
        self.items = items
    }
}

// MARK: Public interface
extension SpendDay_SD {
    convenience init(
        date: Date,
        key: String,
        items: [SpendItem_SD]
    ) {
        self.init(
            id: UUID(),
            date: date,
            key: key,
            items: items
        )
    }
    
    var spendDay: SpendDay {
        SpendDay(
            id: id,
            date: date,
            items: items.map { $0.spendItem }
        )
    }
    
    func setItems(_ items: [SpendItem_SD]) {
        self.items = items
    }
}
