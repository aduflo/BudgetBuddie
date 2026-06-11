//
//  SpendTrendView.swift
//  BudgetIsLife
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
            case .remainingOverspend:
                remainingOverspendView
            case .surplus:
                surplusView
            }
        }
    }
    
    var spendAllowanceView: some View {
        HStack(spacing: Spacing.2) {
            VStack(
                alignment: .leading,
                spacing: Spacing.half
            ) {
                Text(viewModel.spendHeadline)
                    .foregroundStyle(.foregroundPrimary)
                Text(viewModel.displaySpend)
                    .foregroundStyle(budgetColor)
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            
            VStack(
                alignment: .leading,
                spacing: Spacing.half
            ) {
                Text(viewModel.allowanceHeadline)
                Text(viewModel.displayAllowance)
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .foregroundStyle(.foregroundPrimary)
        }
    }
    
    var remainingOverspendView: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.half
        ) {
            Text(viewModel.remainingOverspendHeadline)
                .foregroundStyle(.foregroundPrimary)
            Text(viewModel.displayRemainingOverspend)
                .foregroundStyle(budgetColor)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
    
    var surplusView: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.half
        ) {
            Text(viewModel.surplusHeadline)
                .foregroundStyle(.foregroundPrimary)
            Text(viewModel.displaySurplus)
                .foregroundStyle(surplusColor)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
    
    var budgetColor: Color {
        switch viewModel.evaluateBudget() {
        case .acceptable: Color.green
        case .encroaching: Color.orange
        case .exceeded: Color.red
        }
    }
    
    var surplusColor: Color {
        if viewModel.isSurplusAvailable {
            Color.green
        } else {
            Color.red
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

#Preview("Acceptable; remainingOverspend") {
    SpendTrendView(
        viewModel: .mockAcceptable(
            viewpoint: .remainingOverspend
        )
    )
}

#Preview("Acceptable; surplus") {
    SpendTrendView(
        viewModel: .mockAcceptable(
            viewpoint: .surplus
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

#Preview("Encroaching; remainingOverspend") {
    SpendTrendView(
        viewModel: .mockEncroaching(
            viewpoint: .remainingOverspend
        )
    )
}

#Preview("Encroaching; surplus") {
    SpendTrendView(
        viewModel: .mockEncroaching(
            viewpoint: .surplus
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

#Preview("Exceeded; remainingOverspend") {
    SpendTrendView(
        viewModel: .mockExceeded(
            viewpoint: .remainingOverspend
        )
    )
}

#Preview("Exceeded; surplus") {
    SpendTrendView(
        viewModel: .mockExceeded(
            viewpoint: .surplus
        )
    )
}
