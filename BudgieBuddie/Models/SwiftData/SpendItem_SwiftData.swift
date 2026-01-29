//
//  SpendItem_SwiftData.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/6/26.
//

import Foundation
import SwiftData

@Model
class SpendItem_SwiftData {
    // Instance vars
    @Attribute(.unique) private(set) var id: UUID
    private(set) var amount: Decimal
    private(set) var note: String?
    private(set) var date: Date
    private(set) var createdAt: Date
    
    // Constructors
    init(
        id: UUID,
        amount: Decimal,
        note: String?,
        date: Date,
        createdAt: Date
    ) {
        self.id = id
        self.amount = amount
        self.note = note
        self.date = date
        self.createdAt = createdAt
    }
}
