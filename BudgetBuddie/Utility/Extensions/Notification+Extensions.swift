//
//  NotificationExtensions.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

extension NSNotification.Name {
    static let SettingsUpdated = NSNotification.Name("SettingsUpdated")
    static let SelectedDateUpdated = NSNotification.Name("SelectedDateUpdated")
    static let SpendRepositoryUpdated = NSNotification.Name("SpendRepositoryUpdated")
}

extension Notification {
    static let SettingsUpdated = Notification(name: .SettingsUpdated)
    static let SelectedDateUpdated = Notification(name: .SelectedDateUpdated)
    static let SpendRepositoryUpdated = Notification(name: .SpendRepositoryUpdated)
}
