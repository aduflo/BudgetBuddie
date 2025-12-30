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
            spacing: Spacing.1
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
            
            Text(Copy.spendTrends)
                .font(.headline)
            VStack(
                alignment: .leading,
                spacing: Spacing.1
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
            .padding(Padding.2)
            .roundedRectangleBackground(
                cornerRadius: CornerRadius.2,
                color: .white
            )
        }
        .padding(Padding.2)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
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
