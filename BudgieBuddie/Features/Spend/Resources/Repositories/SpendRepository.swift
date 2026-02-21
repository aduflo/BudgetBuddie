//
//  SpendRepository.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class SpendRepository: SpendRepositable {
    // Instance vars
    let userDefaults: UserDefaultsServiceable
    
    private let store: SpendStoreable = {
        SwiftDataSpendStore()
    }()
    private var didSetupOnce: Bool {
        userDefaults.bool(
            forKey: .didSetupOnce
        )
    }
    
    // Constructors
    init(
        userDefaults: UserDefaultsServiceable
    ) {
        self.userDefaults = userDefaults
    }
    
    // SpendRepositable
    
    func setup(
        calendarService: any CalendarServiceable,
        settingsService: any SettingsServiceable
    ) throws {
        do {
            if didSetupOnce {
                try standardSetup(
                    calendarService: calendarService,
                    settingsService: settingsService
                )
            } else {
                try initialSetup(
                    calendarService: calendarService
                )
            }
        } catch {
            throw SpendRepositoryError.setupFailed
        }
    }

    func getItems(date: Date) throws -> [SpendItem] {
        do {
            let items_data = try store.getItems(date: date)
            let items = items_data.map { SpendItemMapper.toDomainObject($0) }
            return items
        } catch {
            throw SpendRepositoryError.getItemsFailed
        }
    }
    
    func getItems(dates: [Date]) throws -> [SpendItem] {
        do {
            let items_data = try store.getItems(
                dates: dates
            )
            let items = items_data.map { SpendItemMapper.toDomainObject($0) }
            return items
        } catch {
            throw SpendRepositoryError.getItemsFailed
        }
    }
    
    func saveItem(_ item: SpendItem) throws {
        do {
            let item_data = SpendItemMapper.toDataObject(item)
            try store.saveItem(item_data)
            postNotificationSpendRepositoryDidUpdateItem()
        } catch {
            throw SpendRepositoryError.saveItemFailed
        }
    }
    
    func deleteItem(_ item: SpendItem) throws {
        do {
            let item_data = SpendItemMapper.toDataObject(item)
            try store.deleteItem(item_data)
            postNotificationSpendRepositoryDidUpdateItem()
        } catch {
            throw SpendRepositoryError.deleteItemFailed
        }
    }
    
    func getDay(date: Date) throws -> SpendDay {
        do {
            let day_data = try store.getDay(date: date)
            let day = SpendDayMapper.toDomainObject(day_data)
            return day
        } catch {
            throw SpendRepositoryError.getDayFailed
        }
    }
    
    func getDay(id: UUID) throws -> SpendDay {
        do {
            let day_data = try store.getDay(id: id)
            let day = SpendDayMapper.toDomainObject(day_data)
            return day
        } catch {
            throw SpendRepositoryError.getDayFailed
        }
    }
    
    func getAllMonths() throws -> [SpendMonth] {
        do {
            let months_data = try store.getAllMonths()
            let months = months_data.map { SpendMonthMapper.toDomainObject($0) }
            return months
        } catch {
            throw SpendRepositoryError.getAllMonthsFailed
        }
    }
    
    func getMonth(date: Date) throws -> SpendMonth {
        do {
            let month_data = try store.getMonth(
                date: date
            )
            let month = SpendMonthMapper.toDomainObject(month_data)
            return month
        } catch {
            throw SpendRepositoryError.getMonthFailed
        }
    }
}

// MARK: Private interface
private extension SpendRepository {
    // Setup
    func initialSetup(calendarService: any CalendarServiceable) throws {
        do {
            let todayDate = calendarService.todayDate
            try stageNewMonth(todayDate)
            userDefaults.set(
                true,
                forKey: .didSetupOnce
            )
        } catch {
            throw SpendRepositoryError.initialSetupFailed
        }
    }
    
    func standardSetup(
        calendarService: any CalendarServiceable,
        settingsService: any SettingsServiceable
    ) throws {
        let todayDate = calendarService.todayDate
        do {
            _ = try getDay(
                date: todayDate
            )
        } catch {
            if case .getDayFailed = error as? SpendRepositoryError {
                // if we cannot find a SpendDay associated with today's date
                // we can conclude we are in a different month
                // because no SpendDay stored has a `date` value that overlaps with today's date
                // thus, we:
                // - commit staged month to store
                // - stage new month matching today's date
                do {
                    try commitStagedMonth(
                        settingsService: settingsService
                    )
                    try stageNewMonth(todayDate)
                } catch {
                    throw SpendRepositoryError.standardSetupFailed
                }
            }
        }
    }
    
    // Stage/commit month
    func commitStagedMonth(settingsService: SettingsServiceable) throws {        
        // extract days that are not yet committed
        let days_data = try store.getUncommittedDays()
            
        // sort from first-to-last
        let sortedDays_data = days_data.sorted(by: { $0.date < $1.date })
        
        // group days into months, in case multiple months have passed since last open
        var monthDaysDict: [Int: [SpendDay_Data]] = [:]
        for day_data in sortedDays_data {
            let month = Calendar.current.monthInDate(day_data.date)
            if var days = monthDaysDict[month] {
                days.append(day_data)
                monthDaysDict[month] = days
            } else {
                monthDaysDict[month] = [day_data]
            }
        }
        
        var referenceDate: Date?
        for monthDays in monthDaysDict.values {
            // get reference date (date of the first day of last month)
            guard let date = monthDays.first?.date else {
                throw SpendRepositoryError.commitStagedMonthFailed
            }
            if referenceDate == nil {
                // none set so far; auto-assign referenceDate
                referenceDate = date
            } else if let refDate = referenceDate, date > refDate {
                // date is a later date than refDate; re-assign referenceDate
                referenceDate = date
            }
            
            // compose month_data
            let month_data = SpendMonth_Data(
                id: UUID(),
                date: date,
                month: Calendar.current.monthInDate(date),
                year: Calendar.current.yearInDate(date),
                dayIds: monthDays.map { $0.id },
                allowance: settingsService.monthlyAllowance
            )
            
            // save month_data
            try store.saveMonth(month_data)
        }
        
        // post notification
        if let referenceDate {
            postNotificationSpendRepositoryDidCommitStagedMonth(
                date: referenceDate
            )
        }
    }
    
    func stageNewMonth(_ date: Date) throws {
        // have store stage data for month matching date
        try store.stageMonthData(date)
        
        // post notification
        postNotificatioSpendRepositoryDidStageNewMonth()
    }
    
    // Notifications
    func postNotificationSpendRepositoryDidUpdateItem() {
        NotificationCenter.default.post(.SpendRepositoryDidUpdateItem)
    }
    
    func postNotificatioSpendRepositoryDidStageNewMonth() {
        NotificationCenter.default.post(.SpendRepositoryDidStageNewMonth)
    }
    
    func postNotificationSpendRepositoryDidCommitStagedMonth(date: Date) {
        NotificationCenter.default.post(
            name: .SpendRepositoryDidCommitStagedMonth,
            object: nil,
            userInfo: [
                Notification.UserInfoKey.date: date
            ]
        )
    }
}
