//
//  CalendarView.swift
//  BudgieBuddie
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
            headerView
            listView
        }
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(
            NotificationCenter.default.publisher(for: .CalendarServiceDidUpdateTodayDate),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.reloadData()
                }}
            }
        )
    }
    
    var headerView: some View {
        Text(Copy.days)
            .font(.headline)
            .foregroundStyle(.foregroundPrimary)
    }
    
    var listView: some View {
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
                        .id(dayViewModel.id)
                        .onTapGesture {
                            if let selectedDayViewModel = viewModel.selectedDayViewModel {
                                if selectedDayViewModel.monthDay.day == dayViewModel.monthDay.day {
                                    return // abort; selecting same day
                                }
                            }
                            
                            // toggle new selection and persist day vm
                            viewModel.setSelectedDayViewModel(dayViewModel)
                        }
                    }
                    .onAppear {
                        guard let todayDayViewModel = viewModel.todayDayViewModel else {
                            return
                        }
                        
                        viewModel.setSelectedDayViewModel(todayDayViewModel)
                        proxy.scrollTo(
                            todayDayViewModel.id,
                            anchor: .center
                        )
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    CalendarView(
        viewModel: .mock()
    )
}
