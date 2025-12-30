//
//  SpendTrendView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

struct SpendTrendView: View {
    // Instance vars
    let viewModel: SpendTrendViewModel
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.half
        ) {
            Text(viewModel.title)
                .font(.headline)
            HStack(spacing: Spacing.2) {
                VStack(
                    alignment: .leading,
                    spacing: Spacing.half
                ) {
                    Text(Copy.current)
                    Text(viewModel.displayCurrentSpend)
                        .foregroundStyle(viewModel.dailySpendColor)
                }
                VStack(
                    alignment: .leading,
                    spacing: Spacing.half
                ) {
                    Text(Copy.max)
                    Text(viewModel.displayMaxSpend)
                }
            }
        }
    }
}

#Preview("Acceptable") {
    SpendTrendView(viewModel: .mockAcceptable())
}

#Preview("Encroaching") {
    SpendTrendView(viewModel: .mockEncroaching())
}

#Preview("Exceeded") {
    SpendTrendView(viewModel: .mockExceeded())
}
