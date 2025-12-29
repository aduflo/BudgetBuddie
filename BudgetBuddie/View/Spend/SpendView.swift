//
//  SpendView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI

struct SpendView: View {
    // Instance vars
    let viewModel: SpendViewModel
    
    var body: some View {
        VStack(
            spacing: 8.0
        ) {
            HStack {
                Text("Spend summary")
                    .font(.title2)
                Spacer()
                Button(
                    "New spend item",
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
                spacing: 18.0
            ) {
                CalendarView(
                    viewModel: viewModel.calendarViewModel
                )
                
                Divider()
                
                SpendListView(
                    viewModel: viewModel.spendListViewModel
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.25))
        )
        .onReceive(
            NotificationCenter.default.publisher(
                for: .SelectedDateUpdated
            ),
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
