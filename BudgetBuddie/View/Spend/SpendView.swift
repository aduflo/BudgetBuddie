//
//  SpendView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI
import Combine

struct SpendView: View {
    // Instance vars
    let viewModel: SpendViewModel
    
    var body: some View {
        VStack(
            spacing: Spacing.1
        ) {
            HStack {
                Text(Copy.summary)
                    .font(.title2)
                Spacer()
                Button(
                    "new spend item",
                    systemImage: SystemImage.plus,
                    action: { viewModel.newSpendItemTapped() }
                )
                .labelStyle(.iconOnly)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.white)
                .foregroundStyle(.black)
            }
            
            HStack(
                spacing: Spacing.2
            ) {
                SpendListView(
                    viewModel: viewModel.spendListViewModel
                )
                
                Divider()
                
                CalendarView(
                    viewModel: viewModel.calendarViewModel
                )
            }
        }
        .padding(Padding.2)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .gray.opacity(0.25)
        )
        .onReceive(
//            Publishers.Merge(
//                NotificationCenter.default.publisher(for: .SettingsUpdated),
                NotificationCenter.default.publisher(for: .SelectedDateUpdated),
//            ),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.reloadData()
                }}
            }
        )
    }
}

#Preview {
    SpendView(viewModel: .mock())
}
