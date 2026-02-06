//
//  SpendTrendView.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

struct SpendTrendView: View {
    // Instance vars
    private let viewModel: SpendTrendViewModel
    
    // Constructors
    init(
        viewModel: SpendTrendViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.half
        ) {
            Text(viewModel.title)
                .font(.headline)
                .foregroundStyle(.foregroundPrimary)
            
            HStack(spacing: Spacing.2) {
                VStack(
                    alignment: .leading,
                    spacing: Spacing.half
                ) {
                    Text(Copy.spend)
                        .foregroundStyle(.foregroundPrimary)
                    Text(viewModel.displayCurrentSpend)
                        .foregroundStyle(viewModel.dailySpendColor)
                }
                
                VStack(
                    alignment: .leading,
                    spacing: Spacing.half
                ) {
                    Text(Copy.allowance)
                    Text(viewModel.displayMaxSpend)
                }
                .foregroundStyle(.foregroundPrimary)
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
