//
//  SpendTrendViewModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation
import Testing
@testable import BudgieBuddie

struct SpendTrendViewModelTests {
    // MARK: - spendHeadline
    @Test func test_spendHeadline() async {
        // Setup
        let vm = await mockVM(spend: 0, allowance: 0, remaining: 0, warningThreshold: 0)
        
        // Scenario
        let spendHeadline = await vm.spendHeadline
        
        // Verification
        #expect(spendHeadline == Copy.spend)
    }
    
    // MARK: - allowanceHeadline
    @Test func test_allowanceHeadline() async {
        // Setup
        let vm = await mockVM(spend: 0, allowance: 0, remaining: 0, warningThreshold: 0)
        
        // Scenario
        let allowanceHeadline = await vm.allowanceHeadline
        
        // Verification
        #expect(allowanceHeadline == Copy.allowance)
    }
    
    // MARK: - remainingOverspendHeadline
    @Test func test_remainingOverspendHeadline() async {
        // Setup
        let vm1 = await mockVM(spend: 0, allowance: 0, remaining: 1, warningThreshold: 0)
        let vm2 = await mockVM(spend: 0, allowance: 0, remaining: -1, warningThreshold: 0)
        
        // Scenario
        let remainingOverspendHeadline1 = await vm1.remainingOverspendHeadline
        let remainingOverspendHeadline2 = await vm2.remainingOverspendHeadline
        
        // Verification
        #expect(remainingOverspendHeadline1 == Copy.remaining)
        #expect(remainingOverspendHeadline2 == Copy.overspend)
    }

    // MARK: - evaluateBudget()
    @Test func test_evaluateBudget_acceptable() async {
        // Setup
        let vm1 = await mockVM(spend: 0, allowance: 100, remaining: 100, warningThreshold: 0.50)
        let vm2 = await mockVM(spend: 49, allowance: 100, remaining: 51, warningThreshold: 0.50)
        
        // Scenario
        let evaluation1 = await vm1.evaluateBudget()
        let evaluation2 = await vm2.evaluateBudget()
        
        // Verification
        #expect(evaluation1 == .acceptable)
        #expect(evaluation2 == .acceptable)
    }
    
    @Test func test_evaluateBudget_encroaching() async {
        // Setup
        let vm1 = await mockVM(spend: 50, allowance: 100, remaining: 50, warningThreshold: 0.50)
        let vm2 = await mockVM(spend: 99, allowance: 100, remaining: 1, warningThreshold: 0.50)
        
        // Scenario
        let evaluation1 = await vm1.evaluateBudget()
        let evaluation2 = await vm2.evaluateBudget()
        
        // Verification
        #expect(evaluation1 == .encroaching)
        #expect(evaluation2 == .encroaching)
    }
    
    @Test func test_evaluateBudget_exceeded() async {
        // Setup
        let vm = await mockVM(spend: 100, allowance: 100, remaining: 0, warningThreshold: 0.50)
        
        // Scenario
        let evaluation = await vm.evaluateBudget()
        
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
