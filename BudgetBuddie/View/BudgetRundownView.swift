//
//  BudgetRundownView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetRundownView: View {
    let viewModel: BudgetRundownViewModel
    @Environment(\.onSettingsTapped) var onSettingsChanged
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8.0
        ) {
            HStack {
                Text(viewModel.displayDate)
                    .font(.title2)
                Spacer()
                Button("Settings", systemImage: "gear") {
                    onSettingsChanged()
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.white)
                .foregroundStyle(.black)
            }
            
            Text("Spending Trends")
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
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.25))
        )
    }
}

#Preview {
    BudgetRundownView(viewModel: .mock())
}
