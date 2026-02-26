//
//  View+Extensions.swift
//  BudgetIsLife
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
    
    func dismissingKeyboardToolbar(
        isFocused: FocusState<Bool>.Binding
    ) -> some View {
        focused(isFocused)
        .toolbar {
            ToolbarItem(
                placement: .keyboard
            ) {
                if isFocused.wrappedValue {
                    Button(
                        TitleKey.Button.dismissKeyboard,
                        systemImage: SystemImage.keyboardChevronCompactDownFill,
                        action: { isFocused.wrappedValue = false }
                    )
                }
            }
        }
    }
}
