//
//  BudgetListItemView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetListItemView: View {
    let viewModel: BudgetListItemViewModel
    
    var body: some View {
        HStack {
            Text("\(viewModel.displayValue)")
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.red)
        )
    }
}

#Preview {
    BudgetListItemView(viewModel: .mock())
}
