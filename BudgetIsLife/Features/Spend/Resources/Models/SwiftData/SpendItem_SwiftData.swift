//
//  SpendItem_SwiftData.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/6/26.
//

import Foundation
import SwiftData

typealias SpendItem_SwiftData = SpendItemSchemaV1.SpendItem

enum SpendItemSchemaV1: VersionedSchema {
    static let versionIdentifier: Schema.Version = .init(1, 0, 0)
    static let models: [any PersistentModel.Type] = [SpendItem.self]
    
    @Model
    class SpendItem {
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
}
