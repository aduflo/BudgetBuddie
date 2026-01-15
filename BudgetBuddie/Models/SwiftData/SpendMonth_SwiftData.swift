//
//  SpendMonth_SwiftData.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation
import SwiftData

@Model
class SpendMonth_SwiftData {
    // Instance vars
    @Attribute(.unique) private(set) var id: UUID
    private(set) var month: Int
    private(set) var year: Int
    private(set) var spend: Decimal
    private(set) var allowance: Decimal
    
    // Constructors
    init(
        id: UUID,
        month: Int,
        year: Int,
        spend: Decimal,
        allowance: Decimal
    ) {
        self.id = id
        self.month = month
        self.year = year
        self.spend = spend
        self.allowance = allowance
    }
}
