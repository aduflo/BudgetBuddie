//
//  SpendItemMapperTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct SpendItemMapperTests {
    // MARK: toDomainObject()
    @Test func test_toDomainObject() {
        // Setup
        let item_data = SpendItem_Data(
            id: UUID(),
            dayId: UUID(),
            amount: 1.0,
            note: "yar",
            createdAt: Date()
        )
        
        // Scenario
        let item_domain = SpendItemMapper.toDomainObject(item_data)
        
        // Verification
        #expect(item_domain.id == item_data.id)
        #expect(item_domain.dayId == item_data.dayId)
        #expect(item_domain.amount == item_data.amount)
        #expect(item_domain.note == item_data.note)
        #expect(item_domain.createdAt == item_data.createdAt)
    }
    
    // MARK: toDataObject(domain:)
    @Test func toDataObject_from_domain() {
        // Setup
        let item_domain = SpendItem(
            id: UUID(),
            dayId: UUID(),
            amount: 1.0,
            note: "yar",
            createdAt: Date()
        )
        
        // Scenario
        let item_data = SpendItemMapper.toDataObject(item_domain)
        
        // Verification
        #expect(item_data.id == item_domain.id)
        #expect(item_data.dayId == item_domain.dayId)
        #expect(item_data.amount == item_domain.amount)
        #expect(item_data.note == item_domain.note)
        #expect(item_data.createdAt == item_domain.createdAt)
    }
    
    // MARK: toDataObject(swiftData:)
    @Test func toDataObject_from_swiftData() {
        // Setup
        let item_swiftData = SpendItem_SwiftData(
            id: UUID(),
            dayId: UUID(),
            amount: 1.0,
            note: "yar",
            createdAt: Date()
        )
        
        // Scenario
        let item_data = SpendItemMapper.toDataObject(item_swiftData)
        
        // Verification
        #expect(item_data.id == item_swiftData.id)
        #expect(item_data.dayId == item_swiftData.dayId)
        #expect(item_data.amount == item_swiftData.amount)
        #expect(item_data.note == item_swiftData.note)
        #expect(item_data.createdAt == item_swiftData.createdAt)
    }
    
    // MARK: toSwiftDataObject()
    @Test func toSwiftDataObject() {
        // Setup
        let item_data = SpendItem_Data(
            id: UUID(),
            dayId: UUID(),
            amount: 1.0,
            note: "yar",
            createdAt: Date()
        )
        
        // Scenario
        let item_swiftData = SpendItemMapper.toSwiftDataObject(item_data)
        
        // Verification
        #expect(item_swiftData.id == item_data.id)
        #expect(item_swiftData.dayId == item_data.dayId)
        #expect(item_swiftData.amount == item_data.amount)
        #expect(item_swiftData.note == item_data.note)
        #expect(item_swiftData.createdAt == item_data.createdAt)
    }
}
