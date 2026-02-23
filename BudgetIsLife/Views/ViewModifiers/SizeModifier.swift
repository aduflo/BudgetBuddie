//
//  SizeModifier.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 2/8/26.
//

import SwiftUI

// Inspiration: https://swiftwithmajid.com/2020/01/15/the-magic-of-view-preferences-in-swiftui/
struct SizeModifier: ViewModifier {
    func body(
        content: Content
    ) -> some View {
        content.background(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: SizePreferenceKey.self,
                    value: proxy.size
                )
            }
        )
    }
}

extension View {
    func sizePreferenceKeyed(_ action: @escaping (CGSize) -> ()) -> some View {
        modifier(SizeModifier())
            .onPreferenceChange(SizePreferenceKey.self) { action($0) }
    }
}
