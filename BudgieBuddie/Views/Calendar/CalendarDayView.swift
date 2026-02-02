//
//  CalendarDayView.swift
//  BudgieBuddie
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
        Text(viewModel.displayMonthDay)
            .fontWeight(.semibold)
            .foregroundStyle(viewModel.isToday ? .foregroundSecondary : .foregroundPrimary)
            .frame(
                width: 56.0,
                height: 32.0
            )
            .padding(Padding.1)
            .roundedRectangleBackground(
                cornerRadius: CornerRadius.1,
                color: viewModel.isToday ? .appPrimary : .backgroundPrimary,
                strokeColor: viewModel.isSelected ? .foregroundPrimary: .clear,
                strokeWidth: viewModel.isSelected ? StrokeWidth.2 : 0.0
            )
    }
}

#Preview("Selected") {
    CalendarDayView(
        viewModel: CalendarDayViewModel(
            monthDay: .mockPast(),
            isSelected: true
        )
    )
}

#Preview("Not selected") {
    CalendarDayView(
        viewModel: CalendarDayViewModel(
            monthDay: .mockFuture(),
            isSelected: false
        )
    )
}

#Preview("Today selected") {
    CalendarDayView(
        viewModel: CalendarDayViewModel(
            monthDay: .mockPresent(),
            isSelected: true
        )
    )
}

#Preview("Today not selected") {
    CalendarDayView(
        viewModel: CalendarDayViewModel(
            monthDay: .mockPresent(),
            isSelected: false
        )
    )
}
