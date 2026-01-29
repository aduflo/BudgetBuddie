//
//  SpendItemMapper.swift
//  BudgieBuddie
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
            amount: data.amount,
            note: data.note,
            date: data.date,
            createdAt: data.createdAt
        )
    }
    
    static func toDataObject(
        _ domain: SpendItem
    ) -> SpendItem_Data {
        SpendItem_Data(
            id: domain.id,
            amount: domain.amount,
            note: domain.note,
            date: domain.date,
            createdAt: domain.createdAt
        )
    }
    
    static func toDataObject(
        _ swiftData: SpendItem_SwiftData
    ) -> SpendItem_Data {
        SpendItem_Data(
            id: swiftData.id,
            amount: swiftData.amount,
            note: swiftData.note,
            date: swiftData.date,
            createdAt: swiftData.createdAt
        )
    }
    
    static func toSwiftDataObject(
        _ data: SpendItem_Data
    ) -> SpendItem_SwiftData {
        SpendItem_SwiftData(
            id: data.id,
            amount: data.amount,
            note: data.note,
            date: data.date,
            createdAt: data.createdAt
        )
    }
}
