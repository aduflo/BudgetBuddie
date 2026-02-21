//
//  SpendMonth_SwiftData.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation
import SwiftData

@Model
class SpendMonth_SwiftData {
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
