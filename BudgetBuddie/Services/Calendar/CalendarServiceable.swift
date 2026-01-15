//
//  CalendarServiceable.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

protocol CalendarServiceable {
    var selectedDate: Date { get }
    func updateSelectedDate(_ date: Date)
}
