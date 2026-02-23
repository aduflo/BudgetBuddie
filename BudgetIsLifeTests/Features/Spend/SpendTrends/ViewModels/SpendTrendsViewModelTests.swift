//
//  SpendTrendsViewModelTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

@MainActor
struct SpendTrendsViewModelTests {
    // MARK: - useDefaultViewpoint()
    @Test func test_useDefaultViewpoint() {
        // Setup
        let settingsService = MockSettingsService()
        let vm = SpendTrendsViewModel(
            settingsService: settingsService,
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        vm.cycleViewpoint()
        
        // Pre-verification
        #expect(vm.viewpoint != settingsService.defaultSpendTrendViewpoint)
        
        // Scenario
        vm.useDefaultViewpoint()
        
        // Post-Verification
        #expect(vm.viewpoint == settingsService.defaultSpendTrendViewpoint)
    }
    
    // MARK: - cycleViewpoint()
    @Test func test_cycleViewpoint() {
        // Setup
        let settingsService = MockSettingsService()
        let vm = SpendTrendsViewModel(
            settingsService: settingsService,
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.viewpoint == settingsService.defaultSpendTrendViewpoint)
        
        // Scenario
        vm.cycleViewpoint()
        
        // Verification
        #expect(vm.viewpoint != settingsService.defaultSpendTrendViewpoint)
    }
    
    // MARK: - reloadData()
    @Test func test_reloadData() {
        // Setup
        let vm = SpendTrendsViewModel(
            settingsService: MockSettingsService(),
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        let dailyTrendViewModel = vm.dailyTrendViewModel
        let mtdTrendViewModel = vm.mtdTrendViewModel
        let monthlyTrendViewModel = vm.monthlyTrendViewModel
        
        // Scenario
        vm.reloadData()
        
        // Verification
        #expect(vm.dailyTrendViewModel !== dailyTrendViewModel)
        #expect(vm.mtdTrendViewModel !== mtdTrendViewModel)
        #expect(vm.monthlyTrendViewModel !== monthlyTrendViewModel)
    }
}
