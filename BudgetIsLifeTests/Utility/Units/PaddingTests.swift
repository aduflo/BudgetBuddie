//
//  PaddingTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct PaddingTests {
    @Test func test_values() {
        // Verification
        #expect(Padding.zero == 0.0)
        #expect(Padding.half == 4.0)
        #expect(Padding.1 == 8.0)
        #expect(Padding.2 == 16.0)
        #expect(Padding.3 == 32.0)
        #expect(Padding.4 == 64.0)
    }
}
