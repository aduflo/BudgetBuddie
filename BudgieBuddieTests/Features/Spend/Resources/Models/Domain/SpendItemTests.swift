//
//  SpendItemTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

struct SpendItemTests {
    // MARK: updatedCopy()
    @Test func test_updatedCopy() {
        // Setup
        let item = SpendItem(
            id: UUID(),
            dayId: UUID(),
            amount: 1.0,
            note: nil,
            createdAt: Date()
        )
        let amount: Decimal = 2.0
        let note = "yar"
        
        // Scenario
        let updatedItem = item.updatedCopy(
            amount: amount,
            note: note
        )
        
        // Verification
        #expect(updatedItem.id == item.id)
        #expect(updatedItem.dayId == item.dayId)
        #expect(updatedItem.amount == amount)
        #expect(updatedItem.note == note)
        #expect(updatedItem.createdAt == item.createdAt)
    }
}
