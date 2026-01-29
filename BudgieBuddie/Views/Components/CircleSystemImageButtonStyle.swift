//
//  Button+Extensions.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/31/25.
//

import SwiftUI

struct CircleSystemImageButtonStyle: ButtonStyle {
    func makeBody(
        configuration: Configuration
    ) -> some View {
        configuration
            .label
            .labelStyle(.iconOnly)
            .frame(
                width: 40.0,
                height: 40.0
            )
            .foregroundStyle(Color.black)
            .background(Color.white)
            .clipShape(
                Circle()
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.smooth, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == CircleSystemImageButtonStyle {
    static var circleSystemImage: CircleSystemImageButtonStyle { .init() }
}
