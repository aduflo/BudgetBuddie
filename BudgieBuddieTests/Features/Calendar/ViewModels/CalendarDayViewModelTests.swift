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
    // MARK: - setSelected()
    @Test func test_setSelected() {
        // Setup
        let vm = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPast(),
            isSelected: false
        )
        
        // Pre-verification
        #expect(vm.isSelected == false)
        
        // Scenario
        vm.setSelected(true)
        
        // Verification
        #expect(vm.isSelected == true)
    }
    
    // MARK: - displayMonthDay
    @Test func test_displayMonthDay() {
        // Setup
        let vm = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPast(),
            isSelected: false
        )
        // Scenario
        let displayMonthDay = vm.displayMonthDay
        
        // Verification
        #expect(displayMonthDay == "12/31")
    }
    
    // MARK: - isToday
    @Test func test_isToday_true() {
        // Setup
        let vm = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPresent(),
            isSelected: false
        )
        
        // Scenario
        let isToday = vm.isToday
        
        // Verification
        #expect(isToday == true)
    }
    
    @Test func test_isToday_false() {
        // Setup
        let vm = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPast(),
            isSelected: false
        )
        
        // Scenario
        let isToday = vm.isToday
        
        // Verification
        #expect(isToday == false)
    }
}
