//
//  BudgetTrendView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

struct BudgetTrendView: View {
    // Instance vars
    let viewModel: BudgetTrendViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.headline)
            HStack(spacing: 16.0) {
                VStack(alignment: .leading) {
                    Text("Current")
                    Text(viewModel.displayCurrentSpend)
                        .foregroundStyle(viewModel.dailySpendColor)
                }
                VStack(alignment: .leading) {
                    Text("Max")
                    Text(viewModel.displayMaxSpend)
                }
            }
        }
    }
}

#Preview("Acceptable") {
    BudgetTrendView(viewModel: .mockAcceptable())
}

#Preview("Encroaching") {
    BudgetTrendView(viewModel: .mockEncroaching())
}

#Preview("Exceeded") {
    BudgetTrendView(viewModel: .mockExceeded())
}
