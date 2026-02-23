//
//  CalendarViewModelTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/15/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

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
        let date = Date()
        let calendarService: CalendarServiceable = {
            let calendarService = MockCalendarService()
            calendarService.updateTodayDate(date)
            calendarService.updateSelectedDate(.distantFuture)
            return calendarService
        }()
        let vm = CalendarViewModel(
            calendarService: calendarService
        )
        
        // Pre-verification
        #expect(vm.selectedDayViewModel == nil)
        
        // Scenario
        calendarService.updateSelectedDate(date)
        vm.reloadData()
        
        // Post-Verification
        #expect(vm.selectedDayViewModel != nil)
    }
    
    @Test func test_reloadData_doesNot_triggersSideEffectOf_setSelectedDayViewModel_when_selectedDay_not_within_month() {
        // Setup
        let calendarService: CalendarServiceable = {
            let calendarService = MockCalendarService()
            calendarService.updateTodayDate(Date())
            calendarService.updateSelectedDate(.distantFuture)
            return calendarService
        }()
        let vm = CalendarViewModel(
            calendarService: calendarService
        )
        
        // Pre-verification
        #expect(vm.selectedDayViewModel == nil)
        
        // Scenario
        vm.reloadData()
        
        // Post-verification
        #expect(vm.selectedDayViewModel == nil)
    }
    
    // MARK: - todayDayViewModel
    @Test func test_todayDayViewModel() {
        // Setup
        let todayDate = Date()
        let calendarService: CalendarServiceable = {
            let calendarService = MockCalendarService()
            calendarService.updateTodayDate(todayDate)
            return calendarService
        }()
        let vm = CalendarViewModel(
            calendarService: calendarService
        )
        vm.reloadData()
        
        // Scenario
        let todayDayViewModel = vm.todayDayViewModel
        
        // Verification
        guard let todayDayViewModel else {
            Issue.record("could not access todayDayViewModel")
            return
        }
        #expect(todayDayViewModel.monthDay.date.isSameDayAs(todayDate))
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
            calendarService: calendarService,
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
