//
//  SpendMonthlyHistoryItemViewModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/17/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SpendMonthlyHistoryItemViewModelTests {
    // MARK: - displayDate
    @Test func test_displayDate() {
        // Setup
        let vm = SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
        
        // Scenario
        let displayDate = vm.displayDate
        
        // Verification
        #expect(displayDate == "February 2026")
    }
    
    // MARK: - displaySpend
    @Test func test_displaySpend_valid() {
        // Setup
        let vm = SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
        
        // Scenario
        let displaySpend = vm.displaySpend
        
        // Verification
        #expect(displaySpend == "$9,001.00")
    }
    
    // MARK: - displayAllowance
    @Test func test_displayAllowance() {
        // Setup
        let vm = SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
        
        // Scenario
        let displayAllowance = vm.displayAllowance
        
        // Verification
        #expect(displayAllowance == "$9,000.00")
    }
    
    // MARK: - isWithinBudget
    @Test func test_isWithinBudget_true() {
        // Setup
        let spendMonth = SpendMonth(
            date: Date(),
            spend: 10,
            allowance: 20
        )
        let vm = SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: spendMonth
        )
        
        // Scenario
        let isWithinBudget = vm.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == true)
    }
    
    @Test func test_isWithinBudget_false() {
        // Setup
        let spendMonth = SpendMonth(
            date: Date(),
            spend: 20,
            allowance: 10
        )
        let vm = SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: spendMonth
        )
        
        // Scenario
        let isWithinBudget = vm.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == false)
    }
    
    // MARK: - displayBudgetDifference
    @Test func test_displayBudgetDifference() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (.mock(), nil)
        let vm = SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
        
        // Scenario
        let displayBudgetDifference = vm.displayBudgetDifference
        
        // Verification
        #expect(displayBudgetDifference == "-$1.00")
    }
}
