//
//  SpendListViewModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SpendListViewModelTests {
    // MARK: - reloadData()
    @Test func test_reloadData_happyPath() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getItems_returnValue = ([.mock()], nil)
        let vm = SpendListViewModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.title == "")
        #expect(vm.listItemViewModels.isEmpty == true)
        #expect(vm.error == nil)
        
        // Scenario
        vm.reloadData()
        
        // Post-verification
        #expect(vm.title == "02/18")
        #expect(vm.listItemViewModels.isEmpty == false)
        #expect(vm.error == nil)
    }
    
    @Test func test_reloadData_sadPath() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getItems_returnValue = (nil, SpendRepositoryError.getItemsFailed)
        let vm = SpendListViewModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.title == "")
        #expect(vm.listItemViewModels.isEmpty == true)
        #expect(vm.error == nil)
        
        // Scenario
        vm.reloadData()
        
        // Post-verification
        #expect(vm.title == "02/18")
        #expect(vm.listItemViewModels.isEmpty == true)
        #expect(vm.error != nil)
    }
    
    // MARK: - newSpendItemTapped()
    @Test func test_newSpendItemTapped() {
        // Setup
        let vm = SpendListViewModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        var interceptorFlag = false
        vm.onNewSpendItemTapped = { interceptorFlag = true }
        
        // Scenario
        vm.newSpendItemTapped()
        
        // Verification
        #expect(interceptorFlag == true)
    }
    
    // MARK: - spendItemTapped()
    @Test func test_spendItemTapped() {
        // Setup
        let vm = SpendListViewModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        var spendItem: SpendItem? = nil
        vm.onSpendItemTapped = { spendItem = $0 }
        
        // Scenario
        vm.spendItemTapped(.mock())
        
        // Verification
        #expect(spendItem != nil)
    }
}
