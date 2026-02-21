//
//  MonthSpendCalculatorTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/20/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct MonthSpendCalculatorTests {
    // MARK: - calculateSpend()
    @Test func test_calculateSpend_valid() throws {
        // Setup
        let date = Date()
        let dayId = UUID()
        let month = SpendMonth(
            date: date,
            dayIds: [dayId],
            allowance: 0
        )
        let spendRepository: SpendRepositable = {
            let day = SpendDay(
                id: dayId,
                date: date,
                items: (1...10).map {
                    SpendItem(
                        dayId: dayId,
                        amount: Decimal($0),
                        note: nil
                    )
                },
                isCommitted: false
            )
            let spendRepository = MockSpendRepository()
            spendRepository.getDayForId_returnValue = (day, nil)
            return spendRepository
        }()
        
        // Scenario
        let spend = try MonthSpendCalculator.calculateSpend(
            month: month,
            spendRepository: spendRepository
        )
        
        // Verification
        #expect(spend == 55)
    }
    
    @Test func test_calculateSpend_invalid() throws {
        // Setup
        let spendRepository: SpendRepositable = {
            let spendRepository = MockSpendRepository()
            spendRepository.getDayForId_returnValue = (nil, SpendRepositoryError.getDayFailed)
            return spendRepository
        }()
        
        // Scenario
        let spend: Decimal?
        do {
            spend = try MonthSpendCalculator.calculateSpend(
                month: .mock(),
                spendRepository: spendRepository
            )
        } catch {
            spend = nil
        }
        
        // Verification
        #expect(spend == nil)
    }
}
