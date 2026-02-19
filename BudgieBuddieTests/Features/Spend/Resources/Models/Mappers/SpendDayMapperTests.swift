//
//  SpendDayMapperTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

struct SpendDayMapperTests {
    // MARK: toDomainObject()
    @Test func test_toDomainObject() {
        // Setup
        let day_data = SpendDay_Data(
            id: UUID(),
            date: Date(),
            items: [
                SpendItem_Data(
                    id: UUID(),
                    dayId: UUID(),
                    amount: 1.0,
                    note: nil,
                    createdAt: Date()
                )
            ]
        )
        
        // Scenario
        let day_domain = SpendDayMapper.toDomainObject(day_data)
        
        // Verification
        #expect(day_domain.id == day_data.id)
        #expect(day_domain.date == day_data.date)
        #expect(day_domain.items.count == day_data.items.count)
    }
    
    // MARK: toDataObject(domain:)
    @Test func test_toDataObject_from_domain() {
        // Setup
        let day_domain = SpendDay(
            id: UUID(),
            date: Date(),
            items: [.mock()]
        )
        
        // Scenario
        let day_data = SpendDayMapper.toDataObject(day_domain)
        
        // Verification
        #expect(day_data.id == day_domain.id)
        #expect(day_data.date == day_domain.date)
        #expect(day_data.items.count == day_domain.items.count)
    }
    
    // MARK: toDataObject(swiftData:)
    @Test func test_toDataObject_from_swiftData() {
        // Setup
        let day_swiftData = SpendDay_SwiftData(
            id: UUID(),
            date: Date(),
            key: "",
            items: [
                SpendItem_SwiftData(
                    id: UUID(),
                    dayId: UUID(),
                    amount: 1.0,
                    note: nil,
                    createdAt: Date()
                )
            ]
        )
        
        // Scenario
        let day_data = SpendDayMapper.toDataObject(day_swiftData)
        
        // Verification
        #expect(day_data.id == day_swiftData.id)
        #expect(day_data.date == day_swiftData.date)
        #expect(day_data.items.count == day_swiftData.items.count)
    }
    
    // MARK: toSwiftDataObject()
    @Test func test_toSwiftDataObject() {
        // Setup
        let day_data = SpendDay_Data(
            id: UUID(),
            date: Date(),
            items: [
                SpendItem_Data(
                    id: UUID(),
                    dayId: UUID(),
                    amount: 1.0,
                    note: nil,
                    createdAt: Date()
                )
            ]
        )
        
        // Scenario
        let day_swiftData = SpendDayMapper.toSwiftDataObject(day_data)
        
        // Verification
        #expect(day_swiftData.id == day_data.id)
        #expect(day_swiftData.date == day_data.date)
        #expect(day_swiftData.items.count == day_data.items.count)
    }
}
