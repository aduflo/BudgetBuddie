//
//  CalendarServiceTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/15/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

@MainActor
struct CalendarServiceTests {
    // MARK: - updateTodayDate()
    @Test func test_updateTodayDate() {
        // Setup
        let date = Date.distantPast
        let calendarService = CalendarService(
            todayDate: date,
            selectedDate: date
        )
        
        // Scenario
        let newDate = Date.distantFuture
        calendarService.updateTodayDate(newDate)
        
        // Verification
        #expect(calendarService.todayDate == newDate)
    }
    
    @Test func test_updateTodayDate_triggersSideEffectOf_updateSelectedDate() {
        // Setup
        let date = Date.distantPast
        let calendarService = CalendarService(
            todayDate: date,
            selectedDate: date
        )
        
        // Scenario
        let newDate = Date.distantFuture
        calendarService.updateTodayDate(newDate)
        
        // Verification
        #expect(calendarService.selectedDate == newDate)
    }
    
    @Test(.timeLimit(.minutes(1))) func test_todayDate_newValue_triggersSideEffectOf_postsNotification() async {
        // Setup
        let date = Date.distantPast
        let calendarService = CalendarService(
            todayDate: date,
            selectedDate: date
        )
        let notifications = NotificationCenter.default.notifications(named: .CalendarServiceDidUpdateTodayDate)
        
        // Scenario
        let newDate = Date.distantFuture
        calendarService.updateTodayDate(newDate)
        
        // Verification
        let notification = await notifications.makeAsyncIterator().next()
        #expect(notification != nil)
    }
    
    // MARK: - updateSelectedDate()
    @Test func test_updateSelectedDate() {
        // Setup
        let date = Date.distantPast
        let calendarService = CalendarService(
            todayDate: date,
            selectedDate: date
        )
        
        // Scenario
        let newDate = Date.distantFuture
        calendarService.updateSelectedDate(newDate)
        
        // Verification
        #expect(calendarService.selectedDate == newDate)
    }
    
    @Test(.timeLimit(.minutes(1))) func test_selectedDate_newValue_posts_notification() async {
        // Setup
        let date = Date.distantPast
        let calendarService = CalendarService(
            todayDate: date,
            selectedDate: date
        )
        let notifications = NotificationCenter.default.notifications(named: .CalendarServiceDidUpdateSelectedDate)
        
        // Scenario
        let newDate = Date.distantFuture
        calendarService.updateSelectedDate(newDate)
        
        // Verification
        let notification = await notifications.makeAsyncIterator().next()
        #expect(notification != nil)
    }
}
