//
//  NotificationExtensions.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

extension NSNotification.Name {
    static let SettingsDidUpdate = NSNotification.Name("SettingsDidUpdate")
    static let CalendarServiceDidUpdateTodayDate = NSNotification.Name("CalendarServiceDidUpdateTodayDate")
    static let CalendarServiceDidUpdateSelectedDate = NSNotification.Name("CalendarServiceDidUpdateSelectedDate")
    static let SpendRepositoryDidUpdateItem = NSNotification.Name("SpendRepositoryDidUpdateItem")
    static let SpendRepositoryDidStageNewMonth = NSNotification.Name("SpendRepositoryDidStageNewMonth")
    static let SpendRepositoryDidCommitStagedMonth = NSNotification.Name("SpendRepositoryDidCommitStagedMonth")
}

extension Notification {
    static let CalendarServiceDidUpdateTodayDate = Notification(name: .CalendarServiceDidUpdateTodayDate)
    static let SettingsDidUpdate = Notification(name: .SettingsDidUpdate)
    static let CalendarServiceDidUpdateSelectedDate = Notification(name: .CalendarServiceDidUpdateSelectedDate)
    static let SpendRepositoryDidUpdateItem = Notification(name: .SpendRepositoryDidUpdateItem)
    static let SpendRepositoryDidStageNewMonth = Notification(name: .SpendRepositoryDidStageNewMonth)
    static let SpendRepositoryDidCommitStagedMonth = Notification(name: .SpendRepositoryDidCommitStagedMonth)
}

extension Notification {
    enum UserInfoKey {
        static let date = "date"
    }
}
