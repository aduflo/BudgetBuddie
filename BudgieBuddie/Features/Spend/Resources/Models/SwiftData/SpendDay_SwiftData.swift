//
//  SpendDay_SwiftData.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/6/26.
//

import Foundation
import SwiftData

@Model
class SpendDay_SwiftData {
    // Instance vars
    @Attribute(.unique) private(set) var id: UUID
    private(set) var date: Date
    private(set) var key: String
    @Relationship private(set) var items: [SpendItem_SwiftData]
    private(set) var isCommitted: Bool = false // FIXME: faux migration; remove when cutting v1 RC
    
    // Constructors
    init(
        id: UUID,
        date: Date,
        key: String,
        items: [SpendItem_SwiftData],
        isCommitted: Bool
    ) {
        self.id = id
        self.date = date
        self.key = key
        self.items = items
        self.isCommitted = isCommitted
    }
}

// MARK: Public interface
extension SpendDay_SwiftData {    
    func setItems(_ items: [SpendItem_SwiftData]) {
        self.items = items
    }
    
    func setIsCommitted(_ isCommitted: Bool) {
        self.isCommitted = isCommitted
    }
}
