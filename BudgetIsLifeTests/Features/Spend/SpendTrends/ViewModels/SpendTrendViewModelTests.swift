//
//  SpendTrendViewModelTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation
import Testing
@testable import BudgetIsLife

@MainActor
struct SpendTrendViewModelTests {
    // MARK: - spendHeadline
    @Test func test_spendHeadline() {
        // Setup
        let vm =  mockVM(spend: 0, allowance: 0, surplus: 0, warningThreshold: 0)
        
        // Scenario
        let spendHeadline =  vm.spendHeadline
        
        // Verification
        #expect(spendHeadline == "Spend")
    }
    
    // MARK: - allowanceHeadline
    @Test func test_allowanceHeadline() {
        // Setup
        let vm =  mockVM(spend: 0, allowance: 0, surplus: 0, warningThreshold: 0)
        
        // Scenario
        let headline =  vm.allowanceHeadline
        
        // Verification
        #expect(headline == "Allowance")
    }
    
    // MARK: - remainingOverspendHeadline
    @Test func test_remainingOverspendHeadline() {
        // Setup
        let vm1 =  mockVM(spend: 0, allowance: 1, surplus: 0, warningThreshold: 0)
        let vm2 =  mockVM(spend: 1, allowance: 0, surplus: 0,  warningThreshold: 0)
        
        // Scenario
        let headline1 =  vm1.remainingOverspendHeadline
        let headline2 =  vm2.remainingOverspendHeadline
        
        // Verification
        #expect(headline1 == "Remaining")
        #expect(headline2 == "Overspend")
    }
    
    // MARK: - surplusHeadline
    @Test func test_surplusHeadline() {
        // Setup
        let vm =  mockVM(spend: 0, allowance: 0, surplus: 0, warningThreshold: 0)
        
        // Scenario
        let headline =  vm.surplusHeadline
        
        // Verification
        #expect(headline == "Surplus")
    }
    
    // MARK: - displaySpend
    @Test func test_displaySpend() {
        // Setup
        let vm =  mockVM(spend: 10, allowance: 0, surplus: 0, warningThreshold: 0)
        
        // Scenario
        let headline =  vm.displaySpend
        
        // Verification
        #expect(headline == "$10.00")
    }
    
    // MARK: - displayAllowance
    @Test func test_displayAllowance() {
        // Setup
        let vm =  mockVM(spend: 0, allowance: 10, surplus: 0, warningThreshold: 0)
        
        // Scenario
        let headline =  vm.displayAllowance
        
        // Verification
        #expect(headline == "$10.00")
    }
    
    // MARK: - displaySurplus
    @Test func test_displaySurplus() {
        // Setup
        let vm =  mockVM(spend: 0, allowance: 0, surplus: 10, warningThreshold: 0)
        
        // Scenario
        let headline =  vm.displaySurplus
        
        // Verification
        #expect(headline == "$10.00")
    }

    // MARK: - evaluateBudget()
    @Test func test_evaluateBudget_acceptable() {
        // Setup
        let vm1 =  mockVM(spend: 0, allowance: 100, surplus: 0, warningThreshold: 0.50)
        let vm2 =  mockVM(spend: 49, allowance: 100, surplus: 0, warningThreshold: 0.50)
        
        // Scenario
        let evaluation1 =  vm1.evaluateBudget()
        let evaluation2 =  vm2.evaluateBudget()
        
        // Verification
        #expect(evaluation1 == .acceptable)
        #expect(evaluation2 == .acceptable)
    }
    
    @Test func test_evaluateBudget_encroaching() {
        // Setup
        let vm1 =  mockVM(spend: 50, allowance: 100, surplus: 0,  warningThreshold: 0.50)
        let vm2 =  mockVM(spend: 99, allowance: 100, surplus: 0, warningThreshold: 0.50)
        
        // Scenario
        let evaluation1 =  vm1.evaluateBudget()
        let evaluation2 =  vm2.evaluateBudget()
        
        // Verification
        #expect(evaluation1 == .encroaching)
        #expect(evaluation2 == .encroaching)
    }
    
    @Test func test_evaluateBudget_exceeded() {
        // Setup
        let vm =  mockVM(spend: 100, allowance: 100, surplus: 0, warningThreshold: 0.50)
        
        // Scenario
        let evaluation =  vm.evaluateBudget()
        
        // Verification
        #expect(evaluation == .exceeded)
    }
    
    // MARK: - isSurplusAvailable
    @Test func test_isSurplusAvailable() {
        // Setup
        let vm1 = mockVM(spend: 0, allowance: 0, surplus: 1, warningThreshold: 0)
        let vm2 = mockVM(spend: 0, allowance: 0, surplus: 0, warningThreshold: 0)
        
        // Scenario
        let isSurplusAvailable1 = vm1.isSurplusAvailable
        let isSurplusAvailable2 = vm2.isSurplusAvailable
        
        // Verification
        #expect(isSurplusAvailable1 == true)
        #expect(isSurplusAvailable2 == false)
    }
}

fileprivate extension SpendTrendViewModelTests {
    @MainActor
    func mockVM(
        spend: Decimal,
        allowance: Decimal,
        surplus: Decimal,
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
            surplus: surplus
        )
    }
}
