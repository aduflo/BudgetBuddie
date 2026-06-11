//
//  SpendTrendViewpointTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct SpendTrendViewpointTests {
    // MARK: - cycle()
    @Test func test_cycle() {
        // Setup
        var viewpoint1: SpendTrendViewpoint = .spendAllowance
        var viewpoint2: SpendTrendViewpoint = .remainingOverspend
        var viewpoint3: SpendTrendViewpoint = .surplus
        
        // Scenario
        viewpoint1.cycle()
        viewpoint2.cycle()
        viewpoint3.cycle()
        
        // Verification
        #expect(viewpoint1 == .remainingOverspend)
        #expect(viewpoint2 == .surplus)
        #expect(viewpoint3 == .spendAllowance)
    }
    
    // MARK: - displayValue
    @Test func test_displayValue() {
        // Verification
        #expect(SpendTrendViewpoint.spendAllowance.displayValue == "Spend")
        #expect(SpendTrendViewpoint.remainingOverspend.displayValue == "Remaining")
        #expect(SpendTrendViewpoint.surplus.displayValue == "Surplus")
    }
}
