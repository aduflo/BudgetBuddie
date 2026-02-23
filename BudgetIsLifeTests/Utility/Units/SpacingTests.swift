//
//  SpacingTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct SpacingTests {
    @Test func test_values() {
        // Verification
        #expect(Spacing.zero == 0.0)
        #expect(Spacing.half == 4.0)
        #expect(Spacing.1 == 8.0)
        #expect(Spacing.2 == 16.0)
        #expect(Spacing.3 == 32.0)
        #expect(Spacing.4 == 64.0)
    }
}
