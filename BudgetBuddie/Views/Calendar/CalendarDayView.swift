//
//  CalendarDayView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/29/25.
//

import SwiftUI

struct CalendarDayView: View {
    // Instance vars
    private let viewModel: CalendarDayViewModel
    
    // Constructors
    init(viewModel: CalendarDayViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(viewModel.text)
            .frame(
                width: 48.0,
                height: 32.0
            )
            .padding(Padding.1)
            .roundedRectangleBackground(
                cornerRadius: CornerRadius.1,
                color: .white,
                strokeColor: viewModel.isSelected ? .black: .clear,
                strokeWidth: viewModel.isSelected ? StrokeWidth.2 : 0.0
            )
    }
}

#Preview("Selected") {
    CalendarDayView(
        viewModel: CalendarDayViewModel(
            isSelected: true,
            text: "12/25",
            monthDay: .mock()
        )
    )
}

#Preview("Not selected") {
    CalendarDayView(
        viewModel: CalendarDayViewModel(
            isSelected: false,
            text: "12/25",
            monthDay: .mock()
        )
    )
}
