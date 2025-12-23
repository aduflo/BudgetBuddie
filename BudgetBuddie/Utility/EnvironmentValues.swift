//
//  EnvironmentValues.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var onSettingsTapped: () -> () = {}
}

extension View {
    func onSettingsTapped(_ onSettingsTapped: @escaping () -> ()) -> some View {
        environment(\.onSettingsTapped, onSettingsTapped)
    }
}
