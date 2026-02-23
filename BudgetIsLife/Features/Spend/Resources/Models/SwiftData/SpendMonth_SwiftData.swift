//
//  SpendMonth_SwiftData.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation
import SwiftData

typealias SpendMonth_SwiftData = SpendMonthSchemaV1.SpendMonth

enum SpendMonthSchemaV1: VersionedSchema {
    static let versionIdentifier: Schema.Version = .init(1, 0, 0)
    static let models: [any PersistentModel.Type] = [SpendMonth.self]
    
    @Model
    class SpendMonth {
        // Instance vars
        @Attribute(.unique) private(set) var id: UUID
        private(set) var date: Date
        private(set) var month: Int
        private(set) var year: Int
        private(set) var dayIds: [UUID]
        private(set) var allowance: Decimal
        
        // Constructors
        init(
            id: UUID,
            date: Date,
            month: Int,
            year: Int,
            dayIds: [UUID],
            allowance: Decimal
        ) {
            self.id = id
            self.date = date
            self.month = month
            self.year = year
            self.dayIds = dayIds
            self.allowance = allowance
        }
    }
}
