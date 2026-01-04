//
//  SpendListItemView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct SpendListItemView: View {
    // Instance vars
    private let viewModel: SpendListItemViewModel
    
    // Constructors
    init(
        viewModel: SpendListItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            HStack {
                Text(viewModel.displayAmount)
                Spacer()
            }
            Text(viewModel.displayDescription)
        }
        .padding(Padding.1)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.1,
            color: .white
        )
    }
}

#Preview {
    SpendListItemView(
        viewModel: .mock()
    )
}
