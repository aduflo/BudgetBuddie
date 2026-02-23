//
//  SpendItemMapper.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

enum SpendItemMapper {
    static func toDomainObject(
        _ data: SpendItem_Data
    ) -> SpendItem {
        SpendItem(
            id: data.id,
            dayId: data.dayId,
            amount: data.amount,
            note: data.note,
            createdAt: data.createdAt
        )
    }
    
    static func toDataObject(
        _ domain: SpendItem
    ) -> SpendItem_Data {
        SpendItem_Data(
            id: domain.id,
            dayId: domain.dayId,
            amount: domain.amount,
            note: domain.note,
            createdAt: domain.createdAt
        )
    }
    
    static func toDataObject(
        _ swiftData: SpendItem_SwiftData
    ) -> SpendItem_Data {
        SpendItem_Data(
            id: swiftData.id,
            dayId: swiftData.dayId,
            amount: swiftData.amount,
            note: swiftData.note,
            createdAt: swiftData.createdAt
        )
    }
    
    static func toSwiftDataObject(
        _ data: SpendItem_Data
    ) -> SpendItem_SwiftData {
        SpendItem_SwiftData(
            id: data.id,
            dayId: data.dayId,
            amount: data.amount,
            note: data.note,
            createdAt: data.createdAt
        )
    }
}
