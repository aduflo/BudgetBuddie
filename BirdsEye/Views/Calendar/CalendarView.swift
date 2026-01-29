//
//  CalendarView.swift
//  BirdsEye
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
                        ForEach(viewModel.dayViewModels) { dayViewModel in
                            CalendarDayView(
                                viewModel: dayViewModel
                            )
                            .id(dayViewModel.monthDay.day)
                            .onTapGesture {
                                if let selectedDayViewModel = viewModel.selectedDayViewModel {
                                    if selectedDayViewModel.monthDay.day == dayViewModel.monthDay.day {
                                        return // selecting same day, abort
                                    } else {
                                        // untoggle previously selected
                                        selectedDayViewModel.setSelected(false)
                                    }
                                }
                                
                                // toggle new selection and persist day vm
                                dayViewModel.setSelected(true)
                                viewModel.setSelectedDayViewModel(dayViewModel)
                                
                                // update selected date
                                viewModel.updateSelectedDate(dayViewModel.monthDay.date)
                            }
                        }
                        .onAppear {
                            guard let currentDayViewModel = viewModel.currentDayViewModel else {
                                return
                            }
                            
                            currentDayViewModel.setSelected(true)
                            viewModel.setSelectedDayViewModel(currentDayViewModel)
                            proxy.scrollTo(
                                currentDayViewModel.monthDay.day,
                                anchor: .center
                            )
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.reloadData()
        }
    }
}

#Preview {
    CalendarView(
        viewModel: .mock()
    )
}
