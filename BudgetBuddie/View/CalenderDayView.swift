//
//  CalenderDayView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/29/25.
//

import SwiftUI

struct CalenderDayView: View {
    // Instance vars
    @State private var viewModel: CalenderDayViewModel
    
    // Constructors
    init(viewModel: CalenderDayViewModel) {
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
    CalenderDayView(
        viewModel: CalenderDayViewModel(
            isSelected: true,
            text: "12/25",
            monthDay: .mock()
        )
    )
}

#Preview("Not selected") {
    CalenderDayView(
        viewModel: CalenderDayViewModel(
            isSelected: false,
            text: "12/25",
            monthDay: .mock()
        )
    )
}
