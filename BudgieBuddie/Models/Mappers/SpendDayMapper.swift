//
//  SpendDayMapper.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

enum SpendDayMapper {
    static func toDomainObject(
        _ data: SpendDay_Data
    ) -> SpendDay {
        SpendDay(
            id: data.id,
            date: data.date,
            items: data.items.map { SpendItemMapper.toDomainObject($0) }
        )
    }
    
    static func toDataObject(
        _ domain: SpendDay
    ) -> SpendDay_Data {
        SpendDay_Data(
            id: domain.id,
            date: domain.date,
            items: domain.items.map { SpendItemMapper.toDataObject($0) }
        )
    }
    
    static func toDataObject(
        _ swiftData: SpendDay_SwiftData
    ) -> SpendDay_Data {
        SpendDay_Data(
            id: swiftData.id,
            date: swiftData.date,
            items: swiftData.items.map { SpendItemMapper.toDataObject($0) }
        )
    }
    
    static func toSwiftDataObject(
        _ data: SpendDay_Data
    ) -> SpendDay_SwiftData {
        let date = data.date
        let key = SpendDayKey(date).value
        return SpendDay_SwiftData(
            id: data.id,
            date: date,
            key: key,
            items: data.items.map { SpendItemMapper.toSwiftDataObject($0) }
        )
    }
}
