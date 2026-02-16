//
//  SpendTrendViewpointTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

struct SpendTrendViewpointTests {
    // MARK: - cycle()
    @Test func test_cycle() {
        // Setup
        var viewpoint1: SpendTrendViewpoint = .spendAllowance
        var viewpoint2: SpendTrendViewpoint = .remainingOverspend
        
        // Scenario
        viewpoint1.cycle()
        viewpoint2.cycle()
        
        // Verification
        #expect(viewpoint1 == .remainingOverspend)
        #expect(viewpoint2 == .spendAllowance)
    }
    
    // MARK: - displayValue
    @Test func test_displayValue() {
        // Verification
        #expect(SpendTrendViewpoint.spendAllowance.displayValue == "Spend / Allowance")
        #expect(SpendTrendViewpoint.remainingOverspend.displayValue == "Remaining / Overspend")
    }
}
