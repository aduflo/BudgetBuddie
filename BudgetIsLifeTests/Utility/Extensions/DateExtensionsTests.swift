//
//  DateExtensionsTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/10/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct DateExtensionsTests {    
    // MARK: - monthDayString
    @Test func test_monthDayString() {
        // Setup
        let calendar = Calendar.current
        let dateComponents1 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2025,
            month: 01,
            day: 01
        )
        let dateComponents2 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2026,
            month: 02,
            day: 10
        )
        
        // Scenario
        guard let date1 = calendar.date(from: dateComponents1) else {
            Issue.record("could not compose date1")
            return
        }
        guard let date2 = calendar.date(from: dateComponents2) else {
            Issue.record("could not compose date1")
            return
        }
        let monthDayString1 = date1.monthDayString
        let monthDayString2 = date2.monthDayString
        
        // Verification
        #expect(monthDayString1 == "01/01")
        #expect(monthDayString2 == "02/10")
    }
    
    // MARK: - monthDayYearString
    @Test func test_monthDayYearString() {
        // Setup
        let calendar = Calendar.current
        let dateComponents1 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2025,
            month: 01,
            day: 01
        )
        let dateComponents2 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2026,
            month: 02,
            day: 10
        )
        
        // Scenario
        guard let date1 = calendar.date(from: dateComponents1) else {
            Issue.record("could not compose date1")
            return
        }
        guard let date2 = calendar.date(from: dateComponents2) else {
            Issue.record("could not compose date1")
            return
        }
        let monthDayYearString1 = date1.monthDayYearString
        let monthDayYearString2 = date2.monthDayYearString
        
        // Verification
        #expect(monthDayYearString1 == "01/01/2025")
        #expect(monthDayYearString2 == "02/10/2026")
    }
    
    // MARK: - monthYearString
    @Test func test_monthYearString() {
        // Setup
        let calendar = Calendar.current
        let dateComponents1 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2025,
            month: 01,
            day: 01
        )
        let dateComponents2 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2026,
            month: 02,
            day: 01
        )
        
        // Scenario
        guard let date1 = calendar.date(from: dateComponents1) else {
            Issue.record("could not compose date1")
            return
        }
        guard let date2 = calendar.date(from: dateComponents2) else {
            Issue.record("could not compose date1")
            return
        }
        let monthYearString1 = date1.monthYearString
        let monthYearString2 = date2.monthYearString
        
        // Verification
        #expect(monthYearString1 == "January 2025")
        #expect(monthYearString2 == "February 2026")
    }
    
    // MARK: - monthLongString
    @Test func test_monthLongString() {
        // Setup
        let calendar = Calendar.current
        let dateComponents1 = DateComponents(
            timeZone: calendar.timeZone,
            year: 01,
            month: 01,
            day: 01
        )
        let dateComponents2 = DateComponents(
            timeZone: calendar.timeZone,
            year: 01,
            month: 02,
            day: 01
        )
        
        // Scenario
        guard let date1 = calendar.date(from: dateComponents1) else {
            Issue.record("could not compose date1")
            return
        }
        guard let date2 = calendar.date(from: dateComponents2) else {
            Issue.record("could not compose date1")
            return
        }
        let monthLongString1 = date1.monthLongString
        let monthLongString2 = date2.monthLongString
        
        // Verification
        #expect(monthLongString1 == "January")
        #expect(monthLongString2 == "February")
    }
    
    // MARK: - isSameDayAs()
    @Test func test_isSameDayAs() {
        // Setup
        let date1 = Date.distantPast
        let date2 = Date.distantFuture
        
        // Scenario
        let isSameDayAs1 = date1.isSameDayAs(date1)
        let isSameDayAs2 = date2.isSameDayAs(date1)
        
        // Verification
        #expect(isSameDayAs1 == true)
        #expect(isSameDayAs2 == false)
    }
}
