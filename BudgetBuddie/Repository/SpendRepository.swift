//
//  SpendRepository.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

@Observable
class SpendRepository {
    // Instance vars
    private var spendService: SpendServiceable
    private var calendarService: CalendarServiceable // TODO: determine if we even need this. idea is we will for purgeLastMonthIfNeeded... but perhaps we can shove that operation into saveItem which will have a date and we can cross check with Date()
    
    // Constructors
    init(
        spendService: SpendServiceable,
        calendarService: CalendarServiceable
    ) {
        self.spendService = spendService
        self.calendarService = calendarService
        purgeLastMonthIfNeeded()
    }
}

// MARK: Public interface
extension SpendRepository {
//    func itemsForDay(_ day: SpendDay) {
//        
//    }
    func saveItem(_ item: SpendItem) {
        print("\(String(describing: Self.self))-\(#function)-id: \(item.id.uuidString)")
    }
    
    func deleteItem(_ item: SpendItem) {
        print("\(String(describing: Self.self))-\(#function)-id: \(item.id.uuidString)")
    }
}

// MARK: Private interface
private extension SpendRepository {
    func purgeLastMonthIfNeeded() {
        // only want to hold onto current months SpendDay(s) and SpendItem(s)
    }
}
