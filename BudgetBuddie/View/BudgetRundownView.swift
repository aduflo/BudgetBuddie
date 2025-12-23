//
//  BudgetRundownView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetRundownView: View {
    let viewModel: BudgetRundownViewModel
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8.0
        ) {
            Text(viewModel.displayDate)
                .font(.title2)
            
            Text("Trends")
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
                    viewModel: viewModel.monthTrendViewModel
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
