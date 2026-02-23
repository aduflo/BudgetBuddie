//
//  SettingsScreenModelTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

@MainActor
struct SettingsScreenModelTests {
    // MARK: - defaultSpendTrendViewpoint
    @Test func test_defaultSpendTrendViewpoint_triggersSideEffectOf_interactionWith_settingsService() {
        // Setup
        let settingsService = MockSettingsService()
        let vm = SettingsScreenModel(
            settingsService: settingsService,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.defaultSpendTrendViewpoint == .spendAllowance)
        #expect(settingsService.defaultSpendTrendViewpoint == .spendAllowance)
        
        // Scenario
        let spendTrendViewpoint: SpendTrendViewpoint = .remainingOverspend
        vm.defaultSpendTrendViewpoint = spendTrendViewpoint
        
        // Verification
        #expect(vm.defaultSpendTrendViewpoint == spendTrendViewpoint)
        #expect(settingsService.defaultSpendTrendViewpoint == spendTrendViewpoint)
    }
    
    // MARK: - monthlyAllowance / setMonthlyAllowance()
    @Test func test_monthlyAllowance() {
        // Setup
        let vm = SettingsScreenModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.monthlyAllowance == 0.0)
        
        // Scenario
        let monthlyAllowance: Decimal = 13.37
        vm.setMonthlyAllowance(monthlyAllowance)
        
        // Verification
        #expect(vm.monthlyAllowance == monthlyAllowance)
    }
    
    // MARK: - warningThreshold / setWarningThreshold()
    @Test func test_warningTreshold() {
        // Setup
        let vm = SettingsScreenModel(
            settingsService: MockSettingsService(),
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.warningThreshold == 0.0)
        
        // Scenario
        let warningThreshold: Double = 13.37
        vm.setWarningThreshold(warningThreshold)
        
        // Verification
        #expect(vm.warningThreshold == warningThreshold)
    }
}
