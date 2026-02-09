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
            
            switch viewModel.viewpoint {
            case .spendAllowance:
                spendAllowanceView
            case .remaining:
                remainingView
            }
        }
    }
    
    var spendAllowanceView: some View {
        HStack(spacing: Spacing.2) {
            VStack(
                alignment: .leading,
                spacing: Spacing.half
            ) {
                Text(Copy.spend)
                    .foregroundStyle(.foregroundPrimary)
                Text(viewModel.displaySpend)
                    .foregroundStyle({
                        switch viewModel.evaluateBudget() {
                        case .acceptable: Color.green
                        case .encroaching: Color.orange
                        case .exceeded: Color.red
                        }
                    }())
            }
            
            VStack(
                alignment: .leading,
                spacing: Spacing.half
            ) {
                Text(Copy.allowance)
                Text(viewModel.displayAllowance)
            }
            .foregroundStyle(.foregroundPrimary)
        }
    }
    
    var remainingView: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.half
        ) {
            Text(Copy.remaining)
                .foregroundStyle(.foregroundPrimary)
            Text(viewModel.displayRemaining)
                .foregroundStyle({
                    if viewModel.isRemainingAvailable {
                        Color.green
                    } else {
                        Color.red
                    }
                }())
        }
    }
}

#Preview("Acceptable; spendAllowance") {
    SpendTrendView(
        viewModel: .mockAcceptable(
            viewpoint: .spendAllowance
        )
    )
}

#Preview("Acceptable; remaining") {
    SpendTrendView(
        viewModel: .mockAcceptable(
            viewpoint: .remaining
        )
    )
}

#Preview("Encroaching; spendAllowance") {
    SpendTrendView(
        viewModel: .mockEncroaching(
            viewpoint: .spendAllowance
        )
    )
}

#Preview("Encroaching; remaining") {
    SpendTrendView(
        viewModel: .mockEncroaching(
            viewpoint: .remaining
        )
    )
}

#Preview("Exceeded; spendAllowance") {
    SpendTrendView(
        viewModel: .mockExceeded(
            viewpoint: .spendAllowance
        )
    )
}

#Preview("Exceeded; remaining") {
    SpendTrendView(
        viewModel: .mockExceeded(
            viewpoint: .remaining
        )
    )
}
