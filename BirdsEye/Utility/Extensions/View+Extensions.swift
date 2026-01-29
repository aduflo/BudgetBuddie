//
//  View+Extensions.swift
//  BirdsEye
//
//  Created by Adam Duflo on 12/29/25.
//

import SwiftUI

extension View {
    func roundedRectangleBackground(
        cornerRadius: CGFloat,
        color: Color,
        strokeColor: Color = .clear,
        strokeWidth: CGFloat = 0.0
    ) -> some View {
        background(
            RoundedRectangle(
                cornerRadius: cornerRadius
            )
            .fill(color)
            .strokeBorder(
                strokeColor,
                lineWidth: strokeWidth
            )
        )
    }
}
