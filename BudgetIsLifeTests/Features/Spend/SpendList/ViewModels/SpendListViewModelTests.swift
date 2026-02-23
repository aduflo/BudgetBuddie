//
//  SpendListViewModelTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

@MainActor
struct SpendListViewModelTests {
    // MARK: - reloadData()
    @Test func test_reloadData_happyPath() {
        // Setup
        let calendarService: CalendarServiceable = {
            let calendarService = MockCalendarService()
            calendarService.updateSelectedDate(.distantPast)
            return calendarService
        }()
        let spendRepository: SpendRepositable = {
            let spendRepository = MockSpendRepository()
            spendRepository.getItemsForDate_returnValue = ([.mock()], nil)
            return spendRepository
        }()
        let vm = SpendListViewModel(
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Scenario
        vm.reloadData()
        
        // Verification
        #expect(vm.title == "12/31")
        #expect(vm.listItemViewModels.isEmpty == false)
        #expect(vm.error == nil)
    }
    
    @Test func test_reloadData_sadPath() {
        // Setup
        let calendarService: CalendarServiceable = {
            let calendarService = MockCalendarService()
            calendarService.updateSelectedDate(.distantPast)
            return calendarService
        }()
        let spendRepository: SpendRepositable = {
            let spendRepository = MockSpendRepository()
            spendRepository.getItemsForDate_returnValue = (nil, .getItemsFailed)
            return spendRepository
        }()
        let vm = SpendListViewModel(
            calendarService: calendarService,
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Scenario
        vm.reloadData()
        
        // Verification
        #expect(vm.title == "12/31")
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
