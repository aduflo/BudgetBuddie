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
            .foregroundStyle(viewModel.isSelected ? .foregroundSecondary : .foregroundPrimary)
            .underline(viewModel.isToday)
            .frame(
                width: 56.0,
                height: 32.0
            )
            .padding(Padding.1)
            .roundedRectangleBackground(
                cornerRadius: CornerRadius.1,
                color: viewModel.isSelected ? .appPrimary : .backgroundPrimary
            )
    }
}

#Preview("Selected") {
    CalendarDayView(
        viewModel: CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockPast(),
            isSelected: true
        )
    )
}

#Preview("Not selected") {
    CalendarDayView(
        viewModel: CalendarDayViewModel(
            calendarService: MockCalendarService(),
            monthDay: .mockFuture(),
            isSelected: false
        )
    )
}

#Preview("Today selected") {
    let monthDay: MonthDay = .mockPresent()
    let calendarService = MockCalendarService()
    calendarService.updateTodayDate(monthDay.date)
    return CalendarDayView(
        viewModel: CalendarDayViewModel(
            calendarService: calendarService,
            monthDay: monthDay,
            isSelected: true
        )
    )
}

#Preview("Today not selected") {
    let monthDay: MonthDay = .mockPresent()
    let calendarService = MockCalendarService()
    calendarService.updateTodayDate(monthDay.date)
    return CalendarDayView(
        viewModel: CalendarDayViewModel(
            calendarService: calendarService,
            monthDay: monthDay,
            isSelected: false
        )
    )
}
