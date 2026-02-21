//
//  SpendMonthlyHistoryScreenModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/17/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SpendMonthlyHistoryScreenModelTests {
    // MARK: - monthSortAttributeSelection
    @Test func test_monthSortAttributeSelection_newValue_triggersSideEffectOf_reloadData() {
        // Setup
        let spendRepository: SpendRepositable = {
            let spendRepository = MockSpendRepository()
            spendRepository.getAllMonths_returnValue = (nil, SpendRepositoryError.getAllMonthsFailed)
            return spendRepository
        }()
        let vm = SpendMonthlyHistoryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.listItemViewModels.isEmpty == true)
        
        // Scenario
        (spendRepository as? MockSpendRepository)?.getAllMonths_returnValue = ([.mock()], nil)
        vm.monthSortAttributeSelection = .date
        
        // Verification
        #expect(vm.listItemViewModels.isEmpty == false)
    }
    
    // MARK: - sortOrderSelection
    @Test func test_sortOrderSelection_newValue_triggersSideEffectOf_reloadData() {
        // Setup
        let spendRepository: SpendRepositable = {
            let spendRepository = MockSpendRepository()
            spendRepository.getAllMonths_returnValue = (nil, SpendRepositoryError.getAllMonthsFailed)
            return spendRepository
        }()
        let vm = SpendMonthlyHistoryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Pre-verification
        #expect(vm.listItemViewModels.isEmpty == true)
        
        // Scenario
        (spendRepository as? MockSpendRepository)?.getAllMonths_returnValue = ([.mock()], nil)
        vm.sortOrderSelection = .forward
        
        // Verification
        #expect(vm.listItemViewModels.isEmpty == false)
    }
    
    // MARK: - reloadData
    @Test func test_reloadData_happyPath() {
        // Setup
        let spendRepository: SpendRepositable = {
            let spendRepository = MockSpendRepository()
            spendRepository.getAllMonths_returnValue = ([.mock()], nil)
            return spendRepository
        }()
        let vm = SpendMonthlyHistoryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Scenario
        vm.reloadData()
        
        // Verification
        #expect(vm.listItemViewModels.isEmpty == false)
        #expect(vm.error == nil)
    }
    
    @Test func test_reloadData_sadPath() {
        // Setup
        let spendRepository: SpendRepositable = {
            let spendRepository = MockSpendRepository()
            spendRepository.getAllMonths_returnValue = (nil, SpendRepositoryError.getAllMonthsFailed)
            return spendRepository
        }()
        let vm = SpendMonthlyHistoryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter()
        )
        
        // Scenario
        vm.reloadData()
        
        // Verification
        #expect(vm.listItemViewModels.isEmpty == true)
        #expect(vm.error != nil)
    }
    
    // MARK: - sortOrderDisplayValue()
    @Test func test_sortOrderDisplayValue_with_monthSortAttributeSelection_date() {
        // Setup
        let vm = SpendMonthlyHistoryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        vm.monthSortAttributeSelection = .date
        
        // Scenario
        let sortOrderForwardDisplayValue = vm.sortOrderDisplayValue(.forward)
        let sortOrderReverseDisplayValue = vm.sortOrderDisplayValue(.reverse)
        
        // Verification
        #expect(sortOrderForwardDisplayValue == "Oldest")
        #expect(sortOrderReverseDisplayValue == "Newest")
    }
    
    @Test func test_sortOrderDisplayValue_with_monthSortAttributeSelection_spend() {
        // Setup
        let vm = SpendMonthlyHistoryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
        vm.monthSortAttributeSelection = .spend
        
        // Scenario
        let sortOrderForwardDisplayValue = vm.sortOrderDisplayValue(.forward)
        let sortOrderReverseDisplayValue = vm.sortOrderDisplayValue(.reverse)
        
        // Verification
        #expect(sortOrderForwardDisplayValue == "$")
        #expect(sortOrderReverseDisplayValue == "$$$$")
    }
}
