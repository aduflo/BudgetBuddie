//
//  BudgetTrendViewModelTests.swift
//  BudgetBuddieTests
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation
import Testing
@testable import BudgetBuddie
import SwiftUI

struct BudgetTrendViewModelTests {

    // MARK: dailySpendColor
    @Test func test_dailySpendColor_acceptable() async throws {
        // Setup
        let vm1 = mockVM(currentSpend: 0, maxSpend: 100, toleranceThreshold: 0.50)
        let vm2 = mockVM(currentSpend: 49, maxSpend: 100, toleranceThreshold: 0.50)
        
        // Scenarios
        let dailySpendColor1 = await vm1.dailySpendColor
        let dailySpendColor2 = await vm2.dailySpendColor
        
        // Verifications
        #expect(dailySpendColor1 == .green)
        #expect(dailySpendColor2 == .green)
    }
    
    @Test func test_dailySpendColor_encroaching() async throws {
        // Setup
        let vm1 = mockVM(currentSpend: 50, maxSpend: 100, toleranceThreshold: 0.50)
        let vm2 = mockVM(currentSpend: 99, maxSpend: 100, toleranceThreshold: 0.50)
        
        // Scenarios
        let dailySpendColor1 = await vm1.dailySpendColor
        let dailySpendColor2 = await vm2.dailySpendColor
        
        // Verifications
        #expect(dailySpendColor1 == .orange)
        #expect(dailySpendColor2 == .orange)
    }
    
    @Test func test_dailySpendColor_exceeded() async throws {
        // Setup
        let vm = mockVM(currentSpend: 100, maxSpend: 100, toleranceThreshold: 0.50)
        
        // Scenarios
        let dailySpendColor = await vm.dailySpendColor
        
        // Verifications
        #expect(dailySpendColor == .red)
    }
}

fileprivate extension BudgetTrendViewModelTests {
    func mockVM(currentSpend: UInt, maxSpend: UInt, toleranceThreshold: Double) -> BudgetTrendViewModel {
        let mockSettingsRepo = MockSettingsRepo()
        mockSettingsRepo.setToleranceThreshold(toleranceThreshold)
        return BudgetTrendViewModel(
            title: "",
            currentSpend: currentSpend,
            maxSpend: maxSpend,
            settingsRepo: mockSettingsRepo
        )
    }
}
