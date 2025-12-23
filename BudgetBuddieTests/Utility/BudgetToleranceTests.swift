//
//  BudgetToleranceTests.swift
//  BudgetBuddieTests
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation
import Testing
@testable import BudgetBuddie

struct BudgetToleranceTests {

    // MARK: evaluate()
    @Test func test_evaluate_acceptable() async throws {
        // Setup
        let max: Decimal = 100.0
        let tolerance = BudgetTolerance(threshold: 0.50)
        
        // Scenarios
        let minEval = await tolerance.evaluate(spend: 0.0, max: max)
        let maxEval = await tolerance.evaluate(spend: 49.9, max: max)
        
        // Verifications
        #expect(minEval == .acceptable, "0.0 should evaluate to .acceptable")
        #expect(maxEval == .acceptable, "49.9 should evaluate to .acceptable")
    }
    
    @Test func test_evaluate_encroaching() async throws {
        // Setup
        let max: Decimal = 100.0
        let tolerance = BudgetTolerance(threshold: 0.50)
        
        // Scenarios
        let minEval = await tolerance.evaluate(spend: 50.0, max: max)
        let maxEval = await tolerance.evaluate(spend: 99.9, max: max)
        
        // Verifications
        #expect(minEval == .encroaching, "50.0 should evaluate to .encroaching")
        #expect(maxEval == .encroaching, "99.9 should evaluate to .encroaching")
    }
    
    @Test func test_evaluate_exceeded() async throws {
        // Setup
        let max: Decimal = 100.0
        let tolerance = BudgetTolerance(threshold: 0.50)
        
        // Scenarios
        let eval = await tolerance.evaluate(spend: max, max: max)
        
        // Verifications
        #expect(eval == .exceeded, "100.0 should evaluate to .exceeded")
    }
}
