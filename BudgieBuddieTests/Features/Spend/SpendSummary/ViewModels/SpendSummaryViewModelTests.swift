//
//  SpendSummaryViewModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/17/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SpendSummaryViewModelTests {
    // MARK: - settingsTapped()
    @Test func test_settingsTapped() {
        // Setup
        let vm = SpendSummaryViewModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        var interceptorFlag = false
        vm.onSettingsTapped = { interceptorFlag = true }
        
        // Scenario
        vm.settingsTapped()
        
        // Verification
        #expect(interceptorFlag == true)
    }
}
