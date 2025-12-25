//
//  NotificationExtensions.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/25/25.
//

import Foundation

extension NSNotification.Name {
    static let SettingsTapped = NSNotification.Name("SettingsTapped")
    static let ToleranceThresholdUpdated = NSNotification.Name("ToleranceThresholdUpdated")
}

extension Notification {
    static let SettingsTapped = Notification(name: .SettingsTapped)
    static let ToleranceThresholdUpdated = Notification(name: .ToleranceThresholdUpdated)
}
