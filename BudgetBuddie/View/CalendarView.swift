//
//  CalendarView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI

struct CalendarView: View {
    // Instance vars
    @State private var viewModel: CalendarViewModel
    
    // Constructors
    init(
        viewModel: CalendarViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text("Date")
                .font(.headline)
            
            ScrollView {
                // TODO: implement scroll to today
                // TODO: add CalendDayView, to encapsulate ln 37-47
                // TODO: implement selected state
                VStack(
                    alignment: .leading,
                    spacing: 8.0
                ) {
                    ForEach(viewModel.monthDays) { monthDay in
                        Text("\(viewModel.displayMonthDay(monthDay.date))")
                            .frame(
                                width: 48.0,
                                height: 32.0
                            )
                            .padding(8.0)
                            .background(
                                RoundedRectangle(cornerRadius: 8.0)
                                    .fill(.white)
                            )
                            .padding(.horizontal, 16.0)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(width: 64.0)
        }
    }
}

#Preview {
    CalendarView(
        viewModel: .mock()
    )
}
