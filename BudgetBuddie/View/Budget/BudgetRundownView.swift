//
//  BudgetRundownView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI
import Combine

struct BudgetRundownView: View {
    // Instance vars
    let viewModel: BudgetRundownViewModel
    
    // Constructors
    init(
        viewModel: BudgetRundownViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8.0
        ) {
            HStack {
                Text(viewModel.displayDate)
                    .font(.title2)
                Spacer()
                Button(
                    "settings",
                    systemImage: SystemImage.gear,
                    action: { viewModel.settingsTapped() }
                )
                .labelStyle(.iconOnly)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.white)
                .foregroundStyle(.black)
            }
            
            Text(Copy.spendingTrends)
                .font(.headline)
            VStack(
                alignment: .leading,
                spacing: 8.0
            ) {
                BudgetTrendView(
                    viewModel: viewModel.dailyTrendViewModel
                )
                Divider()
                BudgetTrendView(
                    viewModel: viewModel.mtdTrendViewModel
                )
                Divider()
                BudgetTrendView(
                    viewModel: viewModel.monthlyTrendViewModel
                )
            }
            .padding()
            .roundedRectangleBackground(
                cornerRadius: 16.0,
                color: .white
            )
        }
        .padding()
        .roundedRectangleBackground(
            cornerRadius: 16.0,
            color: .gray.opacity(0.25)
        )
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(
            Publishers.Merge(
                NotificationCenter.default.publisher(for: .SettingsUpdated),
                NotificationCenter.default.publisher(for: .SelectedDateUpdated)
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
    BudgetRundownView(viewModel: .mock())
}
