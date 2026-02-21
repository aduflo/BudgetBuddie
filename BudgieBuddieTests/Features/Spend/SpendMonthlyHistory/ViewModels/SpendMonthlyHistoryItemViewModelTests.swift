//
//  SpendMonthlyHistoryItemViewModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/17/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SpendMonthlyHistoryItemViewModelTests {
    // MARK: - displayDate
    @Test func test_displayDate() {
        // Setup
        let spendMonth = SpendMonth(
            date: .distantPast,
            dayIds: [],
            allowance: 0
        )
        let vm = SpendMonthlyHistoryItemViewModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            spendMonth: spendMonth
        )
        
        // Scenario
        let displayDate = vm.displayDate
        
        // Verification
        #expect(displayDate == "December 1")
    }
    
    // MARK: - displaySpend
    @Test func test_displaySpend() {
        // Setup
        let spendRepository: SpendRepositable = {
            let dayId = UUID()
            let day = SpendDay(
                id: dayId,
                date: Date(),
                items: [
                    SpendItem(
                        dayId: dayId,
                        amount: 9001,
                        note: nil
                    )
                ],
                isCommitted: false
            )
            let spendRepository = MockSpendRepository()
            spendRepository.getDayForId_returnValue = (day, nil)
            return spendRepository
        }()
        let vm = SpendMonthlyHistoryItemViewModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
        
        // Scenario
        let displaySpend = vm.displaySpend
        
        // Verification
        #expect(displaySpend == "$9,001.00")
    }
    
    // MARK: - displayAllowance
    @Test func test_displayAllowance() {
        // Setup
        let spendMonth = SpendMonth(
            date: Date(),
            dayIds: [],
            allowance: 9000
        )
        let vm = SpendMonthlyHistoryItemViewModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            spendMonth: spendMonth
        )
        
        // Scenario
        let displayAllowance = vm.displayAllowance
        
        // Verification
        #expect(displayAllowance == "$9,000.00")
    }
    
    // MARK: - isWithinBudget
    @Test func test_isWithinBudget_true() {
        // Setup
        let spendRepository: SpendRepositable = {
            let day = SpendDay(
                date: Date(),
                items: [SpendItem(
                    dayId: UUID(),
                    amount: 10,
                    note: nil
                )],
                isCommitted: false
            )
            let spendRepository = MockSpendRepository()
            spendRepository.getDayForId_returnValue = (day, nil)
            return spendRepository
        }()
        let spendMonth = SpendMonth(
            date: Date(),
            dayIds: [UUID()],
            allowance: 20
        )
        let vm = SpendMonthlyHistoryItemViewModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            spendMonth: spendMonth
        )
        
        // Scenario
        let isWithinBudget = vm.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == true)
    }
    
    @Test func test_isWithinBudget_false() {
        // Setup
        let spendRepository: SpendRepositable = {
            let day = SpendDay(
                date: Date(),
                items: [SpendItem(
                    dayId: UUID(),
                    amount: 20,
                    note: nil
                )],
                isCommitted: false
            )
            let spendRepository = MockSpendRepository()
            spendRepository.getDayForId_returnValue = (day, nil)
            return spendRepository
        }()
        let spendMonth = SpendMonth(
            date: Date(),
            dayIds: [UUID()],
            allowance: 10
        )
        let vm = SpendMonthlyHistoryItemViewModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            spendMonth: spendMonth
        )
        
        // Scenario
        let isWithinBudget = vm.isWithinBudget
        
        // Verification
        #expect(isWithinBudget == false)
    }
    
    // MARK: - displayBudgetDifference
    @Test func test_displayBudgetDifference_positive() {
        // Setup
        let spendRepository: SpendRepositable = {
            let day = SpendDay(
                date: Date(),
                items: [SpendItem(
                    dayId: UUID(),
                    amount: 1,
                    note: nil
                )],
                isCommitted: false
            )
            let spendRepository = MockSpendRepository()
            spendRepository.getDayForId_returnValue = (day, nil)
            return spendRepository
        }()
        let spendMonth = SpendMonth(
            date: Date(),
            dayIds: [UUID()],
            allowance: 2
        )
        let vm = SpendMonthlyHistoryItemViewModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            spendMonth: spendMonth
        )
        
        // Scenario
        let displayBudgetDifference = vm.displayBudgetDifference
        
        // Verification
        #expect(displayBudgetDifference == "$1.00")
    }
    
    @Test func test_displayBudgetDifference_negative() {
        // Setup
        let spendRepository: SpendRepositable = {
            let day = SpendDay(
                date: Date(),
                items: [SpendItem(
                    dayId: UUID(),
                    amount: 1,
                    note: nil
                )],
                isCommitted: false
            )
            let spendRepository = MockSpendRepository()
            spendRepository.getDayForId_returnValue = (day, nil)
            return spendRepository
        }()
        let spendMonth = SpendMonth(
            date: Date(),
            dayIds: [UUID()],
            allowance: 0
        )
        let vm = SpendMonthlyHistoryItemViewModel(
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            spendMonth: spendMonth
        )
        
        // Scenario
        let displayBudgetDifference = vm.displayBudgetDifference
        
        // Verification
        #expect(displayBudgetDifference == "-$1.00")
    }
}
