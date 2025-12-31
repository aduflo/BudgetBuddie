//
//  CalendarView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI

struct CalendarView: View {
    // Instance vars
    private let viewModel: CalendarViewModel
    @State private var selectedDayViewModel: CalendarDayViewModel? = nil
    
    // Constructors
    init(
        viewModel: CalendarViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.1
        ) {
            Text(Copy.days)
                .font(.headline)
            ScrollViewReader { proxy in
                ScrollView(.vertical) {
                    VStack(
                        alignment: .leading,
                        spacing: Spacing.1
                    ) {
                        ForEach(viewModel.dayViewModels) { viewModel in
                            CalendarDayView(
                                viewModel: viewModel
                            )
                            .id(viewModel.monthDay.day)
                            .onTapGesture {
                                if let selectedDayViewModel {
                                    if selectedDayViewModel.monthDay.day == viewModel.monthDay.day {
                                        return // selecting same day, abort
                                    } else {
                                        // untoggle previously selected
                                        selectedDayViewModel.isSelected = false
                                    }
                                }
                                
                                // toggle new selection and persist day vm
                                viewModel.isSelected = true
                                selectedDayViewModel = viewModel
                                
                                // update selected date
                                self.viewModel.updateSelectedDate(viewModel.monthDay.date)
                            }
                        }
                        .onAppear {
                            guard let currentDayViewModel = viewModel.currentDayViewModel else {
                                return
                            }
                            
                            currentDayViewModel.isSelected = true
                            selectedDayViewModel = currentDayViewModel
                            proxy.scrollTo(
                                currentDayViewModel.monthDay.day,
                                anchor: .top
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarView(
        viewModel: .mock()
    )
}
