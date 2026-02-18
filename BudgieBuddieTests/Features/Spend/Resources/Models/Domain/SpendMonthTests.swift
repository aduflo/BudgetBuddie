//
//  SpendMonthTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

struct SpendMonthTests {
    // MARK: isWithinBudget
    @Test func test_isWithinBudget_true() {
        // Setup
        let month = SpendMonth(
            date: Date(),
            spend: 10,
            allowance: 20
        )
        
        // Scenario
        let isWithinBudget = month.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == true)
    }
    
    @Test func test_isWithinBudget_false() {
        // Setup
        let month = SpendMonth(
            date: Date(),
            spend: 20,
            allowance: 10
        )
        
        // Scenario
        let isWithinBudget = month.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == false)
    }
    
    // MARK: budgetDifference
    @Test func test_budgetDifference_positive() {
        // Setup
        let month = SpendMonth(
            id: UUID(),
            date: Date(),
            spend: 10.0,
            allowance: 20.0
        )
        
        // Scenario
        let budgetDifference = month.budgetDifference
        
        // Verification
        #expect(budgetDifference == 10.0)
    }
    
    @Test func test_budgetDifference_equal() {
        // Setup
        let month = SpendMonth(
            id: UUID(),
            date: Date(),
            spend: 10.0,
            allowance: 10.0
        )
        
        // Scenario
        let budgetDifference = month.budgetDifference
        
        // Verification
        #expect(budgetDifference == 0.0)
    }
    
    @Test func test_budgetDifference_negative() {
        // Setup
        let month = SpendMonth(
            id: UUID(),
            date: Date(),
            spend: 20.0,
            allowance: 10.0
        )
        
        // Scenario
        let budgetDifference = month.budgetDifference
        
        // Verification
        #expect(budgetDifference == -10.0)
    }
}
