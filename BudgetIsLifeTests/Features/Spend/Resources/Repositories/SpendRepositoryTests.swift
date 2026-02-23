//
//  SpendRepositoryTests.swift
//  BudgetIsLifeTests
//
//  Created by Adam Duflo on 2/19/26.
//

import Foundation
import Testing
@testable import BudgetIsLife

@MainActor
struct SpendRepositoryTests {
    // MARK: - init()
    @Test func test_init() {
        // Setup
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: MockSpendStore()
        )
        
        // Verification
        #expect(repo.didSetupOnce == false)
    }
    
    // MARK: - setup()
    @Test(.timeLimit(.minutes(1))) func test_setup_firstTime_valid() async throws {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        let notifications = NotificationCenter.default.notifications(named: .SpendRepositoryDidStageNewMonth)
        
        // Scenario
        try repo.setup(
            calendarService: MockCalendarService(),
            settingsService: MockSettingsService()
        )
        
        // Verification
        #expect(repo.didSetupOnce == true)
        #expect(store.stageMonthData_flag == true)
        let notification = await notifications.makeAsyncIterator().next()
        #expect(notification != nil)
    }
    
    @Test func test_setup_firstTime_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        
        // Scenario
        do {
            try repo.setup(
                calendarService: MockCalendarService(),
                settingsService: MockSettingsService()
            )
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .initialSetupFailed else {
                Issue.record("received incorrect error")
                return
            }
            #expect(repo.didSetupOnce == false)
            #expect(store.stageMonthData_flag == false)
        }
    }
    
    @Test func test_setup_futureTime_sameMonth_valid() async {
        // Setup
        let userDefaults = MockUserDefaultsService()
        userDefaults.set(true, forKey: .didSetupOnce)
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: userDefaults,
            store: store
        )
        store.getDayForDate_returnValue = (.mock(), nil)
        
        // Scenario
        do {
            try repo.setup(
                calendarService: MockCalendarService(),
                settingsService: MockSettingsService()
            )
        } catch {
            // Verification
            Issue.record("should not have thrown error: \(error)")
        }
    }
    
    // test_setup_futureTime_sameMonth_invalid() not applicable, given logic would dump into ...futureTime_differentMonth... test cases
    
    @Test(.timeLimit(.minutes(1))) func test_setup_futureTime_differentMonth_valid() async throws {
        // Setup
        let userDefaults = MockUserDefaultsService()
        userDefaults.set(true, forKey: .didSetupOnce)
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: userDefaults,
            store: store
        )
        store.getDayForDate_returnValue = (nil, SpendStoreError.dayNotFound)
        let commitStagedMonthNotifications = NotificationCenter.default.notifications(named: .SpendRepositoryDidCommitStagedMonth)
        let stageNewMonthNotifications = NotificationCenter.default.notifications(named: .SpendRepositoryDidStageNewMonth)
        
        // Scenario
        try repo.setup(
            calendarService: MockCalendarService(),
            settingsService: MockSettingsService()
        )
        
        // Verification
        #expect(store.commitMonth_value != nil)
        let commitStagedMonthNotification = await commitStagedMonthNotifications.makeAsyncIterator().next()
        #expect(commitStagedMonthNotification != nil)
        #expect(store.stageMonthData_flag == true)
        let stageNewMonthNotification = await stageNewMonthNotifications.makeAsyncIterator().next()
        #expect(stageNewMonthNotification != nil)
    }
    
    @Test func test_setup_futureTime_differentMonth_invalid() {
        // Setup
        let userDefaults = MockUserDefaultsService()
        userDefaults.set(true, forKey: .didSetupOnce)
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: userDefaults,
            store: store
        )
        store.getDayForDate_returnValue = (nil, SpendStoreError.dayNotFound)
        store.getUncommittedDays_returnValue = (nil, SpendStoreError.daysNotFound)
        
        // Scenario
        do {
            try repo.setup(
                calendarService: MockCalendarService(),
                settingsService: MockSettingsService()
            )
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .standardSetupFailed else {
                Issue.record("received incorrect error")
                return
            }
            #expect(store.commitMonth_value == nil)
            #expect(store.stageMonthData_flag == false)
        }
    }
    
    // MARK: - getItems(date:)
    @Test func test_getItemsForDate_valid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getItemsDayForDate_returnValue = ([.mock()], nil)
        
        // Scenario
        do {
            _ = try repo.getItems(date: Date())
        } catch {
            // Verification
            Issue.record("should not have thrown error: \(error)")
        }
    }
    
    @Test func test_getItemsForDate_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getItemsDayForDate_returnValue = (nil, .itemsNotFound)
        
        // Scenario
        do {
            _ = try repo.getItems(date: Date())
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .getItemsFailed else {
                Issue.record("received incorrect error")
                return
            }
        }
    }
    
    // MARK: - getItems(dates:)
    @Test func test_getItemsForDates_valid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getItemsDayForDates_returnValue = ([.mock()], nil)
        
        // Scenario
        do {
            _ = try repo.getItems(dates: [Date()])
        } catch {
            // Verification
            Issue.record("should not have thrown error: \(error)")
        }
    }
    
    @Test func test_getItemsForDates_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getItemsDayForDates_returnValue = (nil, .itemsNotFound)
        
        // Scenario
        do {
            _ = try repo.getItems(dates: [Date()])
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .getItemsFailed else {
                Issue.record("received incorrect error")
                return
            }
        }
    }
    
    // MARK: - saveItem()
    @Test(.timeLimit(.minutes(1))) func test_saveItem_valid() async throws {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        let notifications = NotificationCenter.default.notifications(named: .SpendRepositoryDidUpdateItem)
        
        // Scenario
        try repo.saveItem(.mock())
        
        // Verification
        #expect(store.saveItem_value != nil)
        let notification = await notifications.makeAsyncIterator().next()
        #expect(notification != nil)
    }
    
    @Test func test_saveItem_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        
        // Scenario
        do {
            try repo.saveItem(.mock())
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .saveItemFailed else {
                Issue.record("received incorrect error")
                return
            }
            #expect(store.saveItem_value == nil)
        }
    }
    
    // MARK: - deleteItem()
    @Test(.timeLimit(.minutes(1))) func test_deleteItem_valid() async throws {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        let notifications = NotificationCenter.default.notifications(named: .SpendRepositoryDidUpdateItem)
        
        // Scenario
        try repo.deleteItem(.mock())
        
        // Verification
        #expect(store.deleteItem_value != nil)
        let notification = await notifications.makeAsyncIterator().next()
        #expect(notification != nil)
    }
    
    @Test func test_deleteItem_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        
        // Scenario
        do {
            try repo.deleteItem(.mock())
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .deleteItemFailed else {
                Issue.record("received incorrect error")
                return
            }
            #expect(store.deleteItem_value == nil)
        }
    }
    
    // MARK: - getDay(date:)
    @Test func test_getDayForDate_valid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getDayForDate_returnValue = (.mock(), nil)
        
        // Scenario
        do {
            _ = try repo.getDay(date: Date())
        } catch {
            // Verification
            Issue.record("should not have thrown error: \(error)")
        }
    }
    
    @Test func test_getDayForDate_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getDayForDate_returnValue = (nil, .dayNotFound)
        
        // Scenario
        do {
            _ = try repo.getDay(date: Date())
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .getDayFailed else {
                Issue.record("received incorrect error")
                return
            }
        }
    }
    
    // MARK: - getDay(id:)
    @Test func test_getDayForId_valid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getDayForId_returnValue = (.mock(), nil)
        
        // Scenario
        do {
            _ = try repo.getDay(id: UUID())
        } catch {
            // Verification
            Issue.record("should not have thrown error: \(error)")
        }
    }
    
    @Test func test_getDayForId_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getDayForId_returnValue = (nil, .dayNotFound)
        
        // Scenario
        do {
            _ = try repo.getDay(id: UUID())
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .getDayFailed else {
                Issue.record("received incorrect error")
                return
            }
        }
    }
    
    // MARK: - getAllMonths()
    @Test func test_getAllMonths_valid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getAllMonths_returnValue = ([.mock()], nil)
        
        // Scenario
        do {
            _ = try repo.getAllMonths()
        } catch {
            // Verification
            Issue.record("should not have thrown error: \(error)")
        }
    }
    
    @Test func test_getAllMonths_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getAllMonths_returnValue = (nil, .monthsNotFound)
        
        // Scenario
        do {
            _ = try repo.getAllMonths()
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .getAllMonthsFailed else {
                Issue.record("received incorrect error")
                return
            }
        }
    }
    
    // MARK: - getMonth()
    @Test func test_getMonth_valid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getMonth_returnValue = (.mock(), nil)
        
        // Scenario
        do {
            _ = try repo.getMonth(date: Date())
        } catch {
            // Verification
            Issue.record("should not have thrown error: \(error)")
        }
    }
    
    @Test func test_getMonth_invalid() {
        // Setup
        let store = MockSpendStore()
        let repo = SpendRepository(
            userDefaults: MockUserDefaultsService(),
            store: store
        )
        store.getMonth_returnValue = (nil, .monthNotFound)
        
        // Scenario
        do {
            _ = try repo.getMonth(date: Date())
        } catch {
            // Verification
            guard let repoError = error as? SpendRepositoryError,
                  repoError == .getMonthFailed else {
                Issue.record("received incorrect error")
                return
            }
        }
    }
}
