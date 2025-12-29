//
//  SpendListItemView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct SpendListItemView: View {
    // Instance vars
    let viewModel: SpendListItemViewModel
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            HStack {
                Text(viewModel.displayAmount)
                Spacer()
            }
            Text(viewModel.displayNote)
        }
        .padding(8.0)
        .background(
            RoundedRectangle(cornerRadius: 8.0)
                .fill(.white)
        )
    }
    // TODO: need a empty state
}

#Preview {
    SpendListItemView(viewModel: .mock())
}
