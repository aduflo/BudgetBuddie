//
//  CalendarExtensionsTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/10/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

struct CalendarExtensionsTests {
    // MARK: - dayInDate()
    @Test func test_dayInDate() throws {
        // Setup
        let calendar = Calendar.current
        let day1 = 01
        let dateComponents1 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2026,
            month: 01,
            day: day1
        )
        let day2 = 10
        let dateComponents2 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2026,
            month: 01,
            day: day2
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
        let dayInDate1 = Calendar.current.dayInDate(date1)
        let dayInDate2 = Calendar.current.dayInDate(date2)
        
        // Verification
        #expect(dayInDate1 == day1)
        #expect(dayInDate2 == day2)
    }
    
    // MARK: - monthInDate()
    @Test func test_monthInDate() throws {
        // Setup
        let calendar = Calendar.current
        let month1 = 01
        let dateComponents1 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2026,
            month: month1,
            day: 01
        )
        let month2 = 10
        let dateComponents2 = DateComponents(
            timeZone: calendar.timeZone,
            year: 2026,
            month: month2,
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
        let monthInDate1 = Calendar.current.monthInDate(date1)
        let monthInDate2 = Calendar.current.monthInDate(date2)
        
        // Verification
        #expect(monthInDate1 == month1)
        #expect(monthInDate2 == month2)
    }
    
    // MARK: - yearInDate()
    @Test func test_yearInDate() throws {
        // Setup
        let calendar = Calendar.current
        let year1 = 01
        let dateComponents1 = DateComponents(
            timeZone: calendar.timeZone,
            year: year1,
            month: 01,
            day: 01
        )
        let year2 = 10
        let dateComponents2 = DateComponents(
            timeZone: calendar.timeZone,
            year: year2,
            month: 01,
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
        let yearInDate1 = Calendar.current.yearInDate(date1)
        let yearInDate2 = Calendar.current.yearInDate(date2)
        
        // Verification
        #expect(yearInDate1 == year1)
        #expect(yearInDate2 == year2)
    }
    
    // MARK: - daysInMonthInDate()
    @Test func test_daysInMonthInDate() throws {
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
        let daysInMonthInDate1 = Calendar.current.daysInMonthInDate(date1)
        let daysInMonthInDate2 = Calendar.current.daysInMonthInDate(date2)
        
        // Verification
        #expect(daysInMonthInDate1 == 31)
        #expect(daysInMonthInDate2 == 28)
    }
    
    // MARK: - monthDates()
    @Test func test_monthDates() throws {
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
        let monthDates1 = Calendar.current.monthDates(date1)
        let monthDates2 = Calendar.current.monthDates(date2)
        
        // Verification
        #expect(monthDates1.count == 31)
        #expect(monthDates2.count == 28)
    }
}
