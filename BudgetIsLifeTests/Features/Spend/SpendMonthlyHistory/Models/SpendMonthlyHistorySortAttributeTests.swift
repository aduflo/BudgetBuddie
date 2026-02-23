//
//  SpendMonthlyHistorySortAttributeTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct SpendMonthlyHistorySortAttributeTests {
    // MARK: - displayValue
    @Test func test_displayValue() {
        // Verification
        #expect(SpendMonthlyHistorySortAttribute.date.displayValue == "Date")
        #expect(SpendMonthlyHistorySortAttribute.spend.displayValue == "Spend")
    }
}
