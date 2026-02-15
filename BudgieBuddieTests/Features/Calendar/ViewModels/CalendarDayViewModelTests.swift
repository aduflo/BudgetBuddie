//
//  CalendarDayViewModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/15/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct CalendarDayViewModelTests {
    // MARK: - setSelected
    @Test func test_setSelected() {
        // Setup
        let viewModel = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPast(),
            isSelected: false
        )
        
        // Pre-verification
        #expect(viewModel.isSelected == false)
        
        // Scenario
        viewModel.setSelected(true)
        
        // Verification
        #expect(viewModel.isSelected == true)
    }
    
    // MARK: - displayMonthDay
    @Test func test_displayMonthDay() {
        // Setup
        let viewModel = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPast(),
            isSelected: false
        )
        // Scenario
        let displayMonthDay = viewModel.displayMonthDay
        
        // Verification
        #expect(displayMonthDay == "12/31")
    }
    
    // MARK: - isToday
    @Test func test_isToday_true() {
        // Setup
        let viewModel = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPresent(),
            isSelected: false
        )
        
        // Scenario
        let isToday = viewModel.isToday
        
        // Verification
        #expect(isToday == true)
    }
    
    @Test func test_isToday_false() {
        // Setup
        let viewModel = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPast(),
            isSelected: false
        )
        
        // Scenario
        let isToday = viewModel.isToday
        
        // Verification
        #expect(isToday == false)
    }
}
