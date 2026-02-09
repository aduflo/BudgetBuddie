//
//  SpendListItemView.swift
//  BudgieBuddie
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
        HStack(
            spacing: Spacing.zero
        ) {
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                Text(viewModel.displayAmount)
                    .font(.headline)
                
                Text(viewModel.displayNote)
                    .font(.caption)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .foregroundStyle(.foregroundPrimary)
            
            Spacer()
        }
        .padding(Padding.1)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.1,
            color: .backgroundPrimary
        )
    }
}

#Preview {
    SpendListItemView(
        viewModel: .mock()
    )
}
