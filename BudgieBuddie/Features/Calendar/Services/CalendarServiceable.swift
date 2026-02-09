//
//  CalendarServiceable.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

protocol CalendarServiceable {
    var todayDate: Date { get }
    func updateTodayDate(_ date: Date)
    var selectedDate: Date { get }
    func updateSelectedDate(_ date: Date)
}
