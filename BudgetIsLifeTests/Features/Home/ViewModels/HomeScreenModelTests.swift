//
//  HomeScreenModelTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/15/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

@MainActor
struct HomeScreenModelTests {
    // MARK: - didOnboardOnce
    @Test func test_didOnboardOnce() {
        // Setup
        let userDefaults = MockUserDefaultsService()
        let vm = HomeScreenModel(
            userDefaults: userDefaults,
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.didOnboardOnce == false)
        
        // Scenario
        userDefaults.set(true, forKey: .didOnboardOnce)
        
        // Post-verification
        #expect(vm.didOnboardOnce == true)
    }
    
    // MARK: - reloadData()
    @Test func test_reloadData() {
        // Setup
        let vm = HomeScreenModel(
            userDefaults: MockUserDefaultsService(),
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        let spendSummaryViewModel = vm.spendSummaryViewModel
        let spendListViewModel = vm.spendListViewModel
        
        // Scenario
        vm.reloadData()
        
        // Verification
        #expect(vm.spendSummaryViewModel !== spendSummaryViewModel)
        #expect(vm.spendListViewModel !== spendListViewModel)
    }
    
    // MARK: - setSpendItemToPresent()
    @Test func test_setSpendItemToPresent() {
        // Setup
        let vm = HomeScreenModel(
            userDefaults: MockUserDefaultsService(),
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
            userDefaults: MockUserDefaultsService(),
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
