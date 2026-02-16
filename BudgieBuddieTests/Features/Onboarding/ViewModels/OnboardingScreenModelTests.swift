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
        func resetDidOnboardOnce() {
            UserDefaults.standard.set(
                nil,
                forKey: UserDefaults.Key.App.didOnboardOnce
            )
        }
        func didOnboardOnce() -> Bool {
            UserDefaults.standard.bool(forKey: UserDefaults.Key.App.didOnboardOnce)
        }
        resetDidOnboardOnce()
        let vm = OnboardingScreenModel()
        
        // Pre-verification
        #expect(didOnboardOnce() == false)
        
        // Scenario
        vm.setDidOnboardOnce()
        
        // Post-verification
        #expect(didOnboardOnce() == true)
        
        // Teardown
        resetDidOnboardOnce()
    }
}
