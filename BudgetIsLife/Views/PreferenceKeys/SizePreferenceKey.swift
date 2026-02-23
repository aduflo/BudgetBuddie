//
//  SizePreferenceKey.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 2/8/26.
//

import SwiftUI

// Inspiration: https://swiftwithmajid.com/2020/01/15/the-magic-of-view-preferences-in-swiftui/
struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
