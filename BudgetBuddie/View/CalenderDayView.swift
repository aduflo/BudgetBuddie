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
            .padding(8.0)
            .roundedRectangleBackground(
                cornerRadius: 8.0,
                color: .white
            )
            .padding(.horizontal, 16.0)
    }
}

#Preview {
    CalenderDayView(
        text: "12/25"
    )
}
