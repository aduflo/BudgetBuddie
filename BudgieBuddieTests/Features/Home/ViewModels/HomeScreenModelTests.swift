//
//  HomeScreenModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/15/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct HomeScreenModelTests {
    // MARK: - didOnboardOnce
    @Test func test_didOnboardOnce() {
        // Setup
        func setDidOnboardOnce(_ value: Bool?) {
            UserDefaults.standard.set(
                value,
                forKey: UserDefaults.Key.App.didOnboardOnce
            )
        }
        setDidOnboardOnce(nil)
        let vm = HomeScreenModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.didOnboardOnce == false)
        
        // Scenario
        setDidOnboardOnce(true)
        
        // Post-verification
        #expect(vm.didOnboardOnce == true)
        
        // Teardown
        setDidOnboardOnce(nil)
    }
    
    // MARK: - setSpendItemToPresent()
    @Test func test_setSpendItemToPresent() {
        // Setup
        let vm = HomeScreenModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        let item = SpendItem.mock()
        
        // Scenario
        vm.setSpendItemToPresent(item)
        
        // Verification
        #expect(vm.spendItemToPresent == item)
    }
    
    // MARK: - setSpendMonthSummaryDateToPresent()
    @Test func test_setSpendMonthSummaryDateToPresent() {
        // Setup
        let vm = HomeScreenModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        let date = Date.distantPast
        
        // Scenario
        vm.setSpendMonthSummaryDateToPresent(
            date: date
        )
        
        // Verification
        #expect(vm.spendMonthSummaryDateToPresent == date)
    }
}
