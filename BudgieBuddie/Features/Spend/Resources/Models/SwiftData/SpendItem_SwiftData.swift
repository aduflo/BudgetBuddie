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
    private(set) var dayId: UUID
    private(set) var amount: Decimal
    private(set) var note: String?
    private(set) var createdAt: Date
    
    // Constructors
    init(
        id: UUID,
        dayId: UUID,
        amount: Decimal,
        note: String?,
        createdAt: Date
    ) {
        self.id = id
        self.dayId = dayId
        self.amount = amount
        self.note = note
        self.createdAt = createdAt
    }
}
