//
//  SettingsServiceTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SettingsServiceTests {
    // MARK: - monthlyAllowance / setMonthlyAllowance()
    @Test func test_monthlyAllowance() {
        // Setup
        let service = SettingsService(
            userDefaults: MockUserDefaultsService()
        )
        
        // Pre-verification
        #expect(service.monthlyAllowance == 0.0)
        
        // Scenario
        let monthlyAllowance: Decimal = 13.37
        service.setMonthlyAllowance(monthlyAllowance)
        
        // Verification
        #expect(service.monthlyAllowance == monthlyAllowance)
    }
    
    // MARK: - warningThreshold / setWarningThreshold()
    @Test func test_warningThreshold() {
        // Setup
        let service = SettingsService(
            userDefaults: MockUserDefaultsService()
        )
        
        // Pre-verification
        #expect(service.warningThreshold == 0.0)
        
        // Scenario
        let warningThreshold: Double = 13.37
        service.setWarningThreshold(warningThreshold)
        
        // Verification
        #expect(service.warningThreshold == warningThreshold)
    }
    
    // MARK: - defaultSpendTrendViewpoint / setDefaultSpendTrendViewpoint()
    @Test func test_defaultSpendTrendViewpoint() {
        // Setup
        let service = SettingsService(
            userDefaults: MockUserDefaultsService()
        )
        
        // Pre-verification
        #expect(service.defaultSpendTrendViewpoint == .spendAllowance)
        
        // Scenario
        let defaultSpendTrendViewpoint: SpendTrendViewpoint = .remainingOverspend
        service.setDefaultSpendTrendViewpoint(defaultSpendTrendViewpoint)
        
        // Verification
        #expect(service.defaultSpendTrendViewpoint == defaultSpendTrendViewpoint)
    }
}
