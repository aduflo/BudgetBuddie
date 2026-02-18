//
//  SpendTrendViewModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SpendTrendViewModelTests {
    // MARK: - spendHeadline
    @Test func test_spendHeadline() {
        // Setup
        let vm =  mockVM(spend: 0, allowance: 0, remaining: 0, warningThreshold: 0)
        
        // Scenario
        let spendHeadline =  vm.spendHeadline
        
        // Verification
        #expect(spendHeadline == "Spend")
    }
    
    // MARK: - allowanceHeadline
    @Test func test_allowanceHeadline() {
        // Setup
        let vm =  mockVM(spend: 0, allowance: 0, remaining: 0, warningThreshold: 0)
        
        // Scenario
        let allowanceHeadline =  vm.allowanceHeadline
        
        // Verification
        #expect(allowanceHeadline == "Allowance")
    }
    
    // MARK: - remainingOverspendHeadline
    @Test func test_remainingOverspendHeadline() {
        // Setup
        let vm1 =  mockVM(spend: 0, allowance: 0, remaining: 1, warningThreshold: 0)
        let vm2 =  mockVM(spend: 0, allowance: 0, remaining: -1, warningThreshold: 0)
        
        // Scenario
        let remainingOverspendHeadline1 =  vm1.remainingOverspendHeadline
        let remainingOverspendHeadline2 =  vm2.remainingOverspendHeadline
        
        // Verification
        #expect(remainingOverspendHeadline1 == "Remaining")
        #expect(remainingOverspendHeadline2 == "Overspend")
    }

    // MARK: - evaluateBudget()
    @Test func test_evaluateBudget_acceptable() {
        // Setup
        let vm1 =  mockVM(spend: 0, allowance: 100, remaining: 100, warningThreshold: 0.50)
        let vm2 =  mockVM(spend: 49, allowance: 100, remaining: 51, warningThreshold: 0.50)
        
        // Scenario
        let evaluation1 =  vm1.evaluateBudget()
        let evaluation2 =  vm2.evaluateBudget()
        
        // Verification
        #expect(evaluation1 == .acceptable)
        #expect(evaluation2 == .acceptable)
    }
    
    @Test func test_evaluateBudget_encroaching() {
        // Setup
        let vm1 =  mockVM(spend: 50, allowance: 100, remaining: 50, warningThreshold: 0.50)
        let vm2 =  mockVM(spend: 99, allowance: 100, remaining: 1, warningThreshold: 0.50)
        
        // Scenario
        let evaluation1 =  vm1.evaluateBudget()
        let evaluation2 =  vm2.evaluateBudget()
        
        // Verification
        #expect(evaluation1 == .encroaching)
        #expect(evaluation2 == .encroaching)
    }
    
    @Test func test_evaluateBudget_exceeded() {
        // Setup
        let vm =  mockVM(spend: 100, allowance: 100, remaining: 0, warningThreshold: 0.50)
        
        // Scenario
        let evaluation =  vm.evaluateBudget()
        
        // Verification
        #expect(evaluation == .exceeded)
    }
}

fileprivate extension SpendTrendViewModelTests {
    @MainActor
    func mockVM(
        spend: Decimal,
        allowance: Decimal,
        remaining: Decimal,
        warningThreshold: Double
    ) -> SpendTrendViewModel {
        SpendTrendViewModel(
            settingsService: {
                let settingsService = MockSettingsService()
                settingsService.setWarningThreshold(warningThreshold)
                return settingsService
            }(),
            currencyFormatter: CurrencyFormatter(),
            viewpoint: .spendAllowance,
            title: "",
            spend: spend,
            allowance: allowance,
            remaining: remaining
        )
    }
}
