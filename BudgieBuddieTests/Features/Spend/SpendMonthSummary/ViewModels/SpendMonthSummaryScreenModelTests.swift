//
//  SpendMonthSummaryScreenModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/17/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SpendMonthSummaryScreenModelTests {
    // MARK: - init
    @Test func test_init_happyPath() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (.mock(), nil)
        
        // Scenario
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Verification
        #expect(vm.error == nil)
    }
    
    @Test func test_init_sadPath() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (nil, SpendRepositoryError.getMonthFailed)
        
        // Scenario
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Verification
        #expect(vm.error != nil)
    }
    
    // MARK: - displayMonth
    @Test func test_displayMonth_valid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (.mock(), nil)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let displayMonth = vm.displayMonth
        
        // Verification
        #expect(displayMonth == "February")
    }
    
    @Test func test_displayMonth_invalid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (nil, SpendRepositoryError.getMonthFailed)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let displayMonth = vm.displayMonth
        
        // Verification
        #expect(displayMonth.isEmpty)
    }
    
    // MARK: - displaySpend
    @Test func test_displaySpend_valid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (.mock(), nil)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let displaySpend = vm.displaySpend
        
        // Verification
        #expect(displaySpend == "$9,001.00")
    }
    
    @Test func test_displaySpend_invalid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (nil, SpendRepositoryError.getMonthFailed)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let displaySpend = vm.displaySpend
        
        // Verification
        #expect(displaySpend.isEmpty)
    }
    
    // MARK: - displayAllowance
    @Test func test_displayAllowance_valid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (.mock(), nil)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let displayAllowance = vm.displayAllowance
        
        // Verification
        #expect(displayAllowance == "$9,000.00")
    }
    
    @Test func test_displayAllowance_invalid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (nil, SpendRepositoryError.getMonthFailed)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let displayAllowance = vm.displayAllowance
        
        // Verification
        #expect(displayAllowance.isEmpty)
    }
    
    // MARK: - isWithinBudget
    @Test func test_isWithinBudget_true() {
        // Setup
        let spendRepository = MockSpendRepository()
        let spendMonth = SpendMonth(
            date: Date(),
            spend: 10,
            allowance: 20
        )
        spendRepository.getMonth_returnValue = (spendMonth, nil)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let isWithinBudget = vm.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == true)
    }
    
    @Test func test_isWithinBudget_false() {
        // Setup
        let spendRepository = MockSpendRepository()
        let spendMonth = SpendMonth(
            date: Date(),
            spend: 20,
            allowance: 10
        )
        spendRepository.getMonth_returnValue = (spendMonth, nil)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let isWithinBudget = vm.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == false)
    }
    
    @Test func test_isWithinBudget_invalid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (nil, SpendRepositoryError.getMonthFailed)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let isWithinBudget = vm.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == false)
    }
    
    // MARK: - displayBudgetDifference
    @Test func test_displayBudgetDifference_valid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (.mock(), nil)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let displayBudgetDifference = vm.displayBudgetDifference
        
        // Verification
        #expect(displayBudgetDifference == "-$1.00")
    }
    
    @Test func test_displayBudgetDifference_invalid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.getMonth_returnValue = (nil, SpendRepositoryError.getMonthFailed)
        let vm = SpendMonthSummaryScreenModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            date: Date()
        )
        
        // Scenario
        let displayBudgetDifference = vm.displayBudgetDifference
        
        // Verification
        #expect(displayBudgetDifference.isEmpty)
    }
}
