//
//  NotificationExtensions.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

extension NSNotification.Name {
    static let SettingsDidUpdate = NSNotification.Name("SettingsDidUpdate")
    static let SelectedDateDidUpdate = NSNotification.Name("SelectedDateDidUpdate")
    static let SpendRepositoryDidUpdateItem = NSNotification.Name("SpendRepositoryDidUpdateItem")
    static let SpendRepositoryDidStageNewMonth = NSNotification.Name("SpendRepositoryDidStageNewMonth")
    static let SpendRepositoryDidCommitStagedMonth = NSNotification.Name("SpendRepositoryDidCommitStagedMonth")
}

extension Notification {
    static let SettingsDidUpdate = Notification(name: .SettingsDidUpdate)
    static let SelectedDateDidUpdate = Notification(name: .SelectedDateDidUpdate)
    static let SpendRepositoryDidUpdateItem = Notification(name: .SpendRepositoryDidUpdateItem)
    static let SpendRepositoryDidStageNewMonth = Notification(name: .SpendRepositoryDidStageNewMonth)
    static let SpendRepositoryDidCommitStagedMonth = Notification(name: .SpendRepositoryDidCommitStagedMonth)
}

extension Notification {
    enum UserInfoKey {
        static let date = "date"
    }
}
