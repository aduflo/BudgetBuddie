//
//  Button+Extensions.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/31/25.
//

import SwiftUI

extension Button {
    func circleBackground(
        tintColor: Color = .white,
        foregroundColor: Color = .black
    ) -> some View {
        labelStyle(.iconOnly)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.circle)
            .tint(tintColor)
            .foregroundStyle(foregroundColor)
    }
}
