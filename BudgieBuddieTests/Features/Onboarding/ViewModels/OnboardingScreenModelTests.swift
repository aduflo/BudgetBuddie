//
//  OnboardingScreenModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct OnboardingScreenModelTests {
    // MARK: - setDidOnboardOnce()
    @Test func test_setDidOnboardOnce() {
        // Setup
        let userDefaults = MockUserDefaultsService()
        let vm = OnboardingScreenModel(
            userDefaults: userDefaults
        )
        
        // Pre-verification
        #expect(userDefaults.bool(forKey: .didOnboardOnce) == false)
        
        // Scenario
        vm.setDidOnboardOnce()
        
        // Post-verification
        #expect(userDefaults.bool(forKey: .didOnboardOnce) == true)
    }
}
