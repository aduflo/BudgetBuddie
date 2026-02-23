//
//  CornerRadiusTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct CornerRadiusTests {
    @Test func test_values() {
        // Verification
        #expect(CornerRadius.1 == 8.0)
        #expect(CornerRadius.2 == 16.0)
    }
}
