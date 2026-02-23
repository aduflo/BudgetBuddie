//
//  SpendListItemViewModelTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct SpendListItemViewModelTests {
    // MARK: - displayAmount
    @Test func test_displayAmount() {
        // Setup
        let spendItem = SpendItem(
            dayId: UUID(),
            amount: 13.37,
            note: "Leet"
        )
        let vm = SpendListItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendItem: spendItem
        )
        
        // Scenario
        let displayAmount = vm.displayAmount
        
        // Verification
        #expect(displayAmount == "$13.37")
    }
    
    // MARK: - displayNote
    @Test func test_displayNote_with_value() {
        // Setup
        let spendItem = SpendItem(
            dayId: UUID(),
            amount: 13.37,
            note: "Leet"
        )
        let vm = SpendListItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendItem: spendItem
        )
        
        // Scenario
        let displayNote = vm.displayNote
        
        // Verification
        #expect(displayNote == "Leet")
    }
    
    @Test func test_displayNote_without_value() {
        // Setup
        let spendItem = SpendItem(
            dayId: UUID(),
            amount: 13.37,
            note: nil
        )
        let vm = SpendListItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendItem: spendItem
        )
        
        // Scenario
        let displayNote = vm.displayNote
        
        // Verification
        #expect(displayNote == "No note provided")
    }
}
