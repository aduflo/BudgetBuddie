//
//  SpendMonthlyHistorySortAttribute.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/20/26.
//

import Foundation

enum SpendMonthlyHistorySortAttribute: CaseIterable, Identifiable {
    case date
    case spend
    
    // Identifiable
    var id: Self { self }
}
