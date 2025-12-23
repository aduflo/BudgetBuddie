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
            spacing: 16.0
        ) {
            Text(viewModel.displayDate)
            HStack {
                VStack(alignment: .leading) {
                    Text("Spend")
                    Text(viewModel.displayDailySpend)
                        .foregroundStyle(viewModel.dailySpendColor)
                }
                VStack(alignment: .leading) {
                    Text("Max")
                    Text(viewModel.displayDailyMax)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.25))
        )
//        .foregroundStyle(.white)
        .fontWeight(.bold)
    }
}

#Preview {
    BudgetRundownView(viewModel: .mock())
}
