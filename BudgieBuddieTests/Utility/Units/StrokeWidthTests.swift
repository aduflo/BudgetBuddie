//
//  StrokeWidthTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

struct StrokeWidthTests {
    @Test func test_values() {
        // Verification
        #expect(StrokeWidth.1 == 1.0)
        #expect(StrokeWidth.2 == 2.0)
    }
}
