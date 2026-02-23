//
//  SpendDayKeyTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct SpendDayKeyTests {
    @Test func test_value() {
        // Setup
        let key = SpendDayKey(.distantFuture)
        
        // Verification
        #expect(key.value == "12/31/4000")
    }
}
