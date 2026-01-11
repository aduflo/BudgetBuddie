//
//  SpendDay_SwiftData.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/6/26.
//

import Foundation
import SwiftData

@Model
class SpendDay_SwiftData {
    // Instance vars
    @Attribute(.unique) private(set) var id: UUID
    private(set) var date: Date
    private(set) var key: String
    @Relationship(deleteRule: .cascade) private(set) var items: [SpendItem_SwiftData]
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        key: String,
        items: [SpendItem_SwiftData]
    ) {
        self.id = id
        self.date = date
        self.key = key
        self.items = items
    }
}

// MARK: Public interface
extension SpendDay_SwiftData {    
    func setItems(_ items: [SpendItem_SwiftData]) {
        self.items = items
    }
}
