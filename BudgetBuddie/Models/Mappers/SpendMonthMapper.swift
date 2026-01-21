//
//  SpendMonthMapper.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation

enum SpendMonthMapper {
    static func toDomainObject(
        _ data: SpendMonth_Data
    ) -> SpendMonth {
        SpendMonth(
            id: data.id,
            date: data.date,
            spend: data.spend,
            allowance: data.allowance
        )
    }
    
    static func toDataObject(
        _ swiftData: SpendMonth_SwiftData
    ) -> SpendMonth_Data {
        SpendMonth_Data(
            id: swiftData.id,
            date: swiftData.date,
            month: swiftData.month,
            year: swiftData.year,
            spend: swiftData.spend,
            allowance: swiftData.allowance
        )
    }
    
    static func toSwiftDataObject(
        _ data: SpendMonth_Data
    ) -> SpendMonth_SwiftData {
        SpendMonth_SwiftData(
            id: data.id,
            date: data.date,
            month: data.month,
            year: data.year,
            spend: data.spend,
            allowance: data.allowance
        )
    }
}
