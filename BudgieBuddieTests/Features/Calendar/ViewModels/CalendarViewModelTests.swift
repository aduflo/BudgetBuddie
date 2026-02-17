//
//  CalendarViewModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/15/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct CalendarViewModelTests {
    // MARK: - reloadData()
    @Test func test_reloadData() {
        // Setup
        let vm = CalendarViewModel(
            calendarService: MockCalendarService()
        )
        
        // Scenario
        vm.reloadData()
        
        // Verification
        #expect(vm.dayViewModels.count > 0)
    }
    
    @Test func test_reloadData_triggersSideEffectOf_setSelectedDayViewModel_when_selectedDay_within_month() {
        // Setup
        let calendarService = MockCalendarService()
        let vm = CalendarViewModel(
            calendarService: calendarService
        )
        
        // Pre-verification
        #expect(vm.selectedDayViewModel == nil)
        
        // Scenario
        let date = Date()
        calendarService.updateTodayDate(date)
        calendarService.updateSelectedDate(date)
        vm.reloadData()
        
        // Post-verification
        #expect(vm.selectedDayViewModel != nil)
    }
    
    @Test func test_reloadData_doesNot_triggersSideEffectOf_setSelectedDayViewModel_when_selectedDay_not_within_month() {
        // Setup
        let calendarService = MockCalendarService()
        let vm = CalendarViewModel(
            calendarService: calendarService
        )
        
        // Pre-verification
        #expect(vm.selectedDayViewModel == nil)
        
        // Scenario
        calendarService.updateTodayDate(Date())
        calendarService.updateSelectedDate(.distantPast)
        vm.reloadData()
        
        // Post-verification
        #expect(vm.selectedDayViewModel == nil)
    }
    
    // MARK: - todayDayViewModel
    @Test func test_todayDayViewModel_valid() {
        // Setup
        let vm = CalendarViewModel(
            calendarService: MockCalendarService()
        )
        vm.reloadData()
        
        // Scenario
        let todayDayViewModel = vm.todayDayViewModel
        
        // Verification
        #expect(todayDayViewModel != nil)
    }
    
    @Test func test_todayDayViewModel_invalid() {
        // Setup
        let vm = CalendarViewModel(
            calendarService: MockCalendarService()
        )
        
        // Scenario
        let todayDayViewModel = vm.todayDayViewModel
        
        // Verification
        #expect(todayDayViewModel == nil)
    }
    
    // MARK: - setSelectedDayViewModel()
    @Test func test_setSelectedDayViewModel() {
        // Setup
        let calendarService = MockCalendarService()
        calendarService.updateSelectedDate(.distantPast)
        let vm = CalendarViewModel(
            calendarService: calendarService
        )
        let dayVm = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPresent(),
            isSelected: false
        )
        
        // Pre-verification
        #expect(dayVm.isSelected == false)
        #expect(vm.selectedDayViewModel == nil)
        #expect(calendarService.selectedDate == .distantPast)
        
        // Scenario
        vm.setSelectedDayViewModel(dayVm)
        
        // Post-verification
        #expect(dayVm.isSelected == true)
        #expect(vm.selectedDayViewModel != nil)
        #expect(calendarService.selectedDate == dayVm.monthDay.date)
    }
    
    @Test func test_setSelectedDayViewModel_untoggles_previous_selectedDayViewModel() {
        // Setup
        let vm = CalendarViewModel(
            calendarService: MockCalendarService()
        )
        let pastDayVm = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPast(),
            isSelected: false
        )
        let presentDayVm = CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPresent(),
            isSelected: false
        )
        
        // Scenario 1
        vm.setSelectedDayViewModel(pastDayVm)
        
        // Verification 1
        #expect(pastDayVm.isSelected == true)
        #expect(vm.selectedDayViewModel?.monthDay.date == pastDayVm.monthDay.date)
        
        // Scenario 2
        vm.setSelectedDayViewModel(presentDayVm)
        
        // Verification 2
        #expect(pastDayVm.isSelected == false)
        #expect(vm.selectedDayViewModel?.monthDay.date == presentDayVm.monthDay.date)
    }
}
