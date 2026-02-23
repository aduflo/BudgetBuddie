//
//  SpendMonthMapperTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct SpendMonthMapperTests {
    // MARK: toDomainObject()
    @Test func test_toDomainObject() {
        // Setup
        let month_data = SpendMonth_Data(
            id: UUID(),
            date: Date(),
            month: 01,
            year: 2026,
            dayIds: [UUID()],
            allowance: 2.0
        )
        
        // Scenario
        let month_domain = SpendMonthMapper.toDomainObject(month_data)
        
        // Verification
        #expect(month_domain.id == month_data.id)
        #expect(month_domain.date == month_data.date)
        #expect(month_domain.dayIds == month_data.dayIds)
        #expect(month_domain.allowance == month_data.allowance)
    }
    
    // MARK: toDataObject()
    @Test func test_toDataObject() {
        // Setup
        let month_swiftData = SpendMonth_SwiftData(
            id: UUID(),
            date: Date(),
            month: 01,
            year: 2026,
            dayIds: [UUID()],
            allowance: 2.0
        )
        
        // Scenario
        let month_data = SpendMonthMapper.toDataObject(month_swiftData)
        
        // Verification
        #expect(month_data.id == month_swiftData.id)
        #expect(month_data.date == month_swiftData.date)
        #expect(month_data.month == month_swiftData.month)
        #expect(month_data.year == month_swiftData.year)
        #expect(month_data.dayIds == month_swiftData.dayIds)
        #expect(month_data.allowance == month_swiftData.allowance)
    }
    
    // MARK: toSwiftDataObject()
    @Test func test_toSwiftDataObject() {
        // Setup
        let month_data = SpendMonth_Data(
            id: UUID(),
            date: Date(),
            month: 01,
            year: 2026,
            dayIds: [UUID()],
            allowance: 2.0
        )
        
        // Scenario
        let month_swiftData = SpendMonthMapper.toSwiftDataObject(month_data)
        
        // Verification
        #expect(month_swiftData.id == month_data.id)
        #expect(month_swiftData.date == month_data.date)
        #expect(month_swiftData.month == month_data.month)
        #expect(month_swiftData.year == month_data.year)
        #expect(month_swiftData.dayIds == month_data.dayIds)
        #expect(month_swiftData.allowance == month_data.allowance)
    }
}
