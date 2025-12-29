//
//  CalendarView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI

struct CalendarView: View {
    // Instance vars
    let viewModel: CalendarViewModel
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text(Copy.date)
                .font(.headline)
            
            ScrollViewReader { proxy in
                ScrollView {
                    // TODO: implement selected state
                    // might need to convert to List (not scrollview + vstack) for selected state, since it has it implemented
                    // could create @Bindable for calendarService.selectedDate or something... ZzZzzzZzz
                    VStack(
                        alignment: .leading,
                        spacing: 8.0
                    ) {
                        ForEach(viewModel.monthDays) { monthDay in
                            CalenderDayView(
                                text: viewModel.displayMonthDay(monthDay.date)
                            )
                            .id(monthDay.day)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .onAppear {
                        proxy.scrollTo(
                            viewModel.currentMonthDay?.day,
                            anchor: .top
                        )
                    }
                }
                .frame(width: 64.0)
            }
        }
    }
}

#Preview {
    CalendarView(
        viewModel: .mock()
    )
}
