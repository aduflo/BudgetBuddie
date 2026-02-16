//
//  UserDefaultsKeyTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

struct UserDefaultsKeyTests {
    // MARK: - value
    @Test func test_value() {
        // Verification
        #expect(UserDefaultsKey.didOnboardOnce.value == "app.didOnboardOnce")
        #expect(UserDefaultsKey.monthlyAllowance.value == "settings.monthlyAllowance")
        #expect(UserDefaultsKey.warningThreshold.value == "settings.warningThreshold")
        #expect(UserDefaultsKey.defaultSpendTrendViewpoint.value == "settings.defaultSpendTrendViewpoint")
        #expect(UserDefaultsKey.didSetupOnce.value == "spendRepository.didSetupOnce")
    }
}
