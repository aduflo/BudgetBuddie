//
//  CalenderDayView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/29/25.
//

import SwiftUI

struct CalenderDayView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .frame(
                width: 48.0,
                height: 32.0
            )
            .padding(Padding.1)
            .roundedRectangleBackground(
                cornerRadius: CornerRadius.1,
                color: .white
            )
            .padding(.horizontal, Padding.2)
    }
}

#Preview {
    CalenderDayView(
        text: "12/25"
    )
}
