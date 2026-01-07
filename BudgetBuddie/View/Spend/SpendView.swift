//
//  SpendView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI
import Combine

struct SpendView: View {
    // Instance vars
    private let viewModel: SpendViewModel
    
    // Constructors
    init(
        viewModel: SpendViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            spacing: Spacing.1
        ) {
            HStack {
                Text(viewModel.title)
                    .font(.title2)
                Spacer()
                Button(
                    ButtonKey.newSpendItem,
                    systemImage: SystemImage.plus,
                    action: { viewModel.newSpendItemTapped() }
                )
                .buttonStyle(.circleSystemImage)
            }
            
            SpendListView(
                viewModel: viewModel.spendListViewModel
            )
        }
        .padding(Padding.2)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .gray.opacity(0.25)
        )
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(
            NotificationCenter.default.publisher(for: .SelectedDateUpdated),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.reloadData()
                }}
            }
        )
    }
}

#Preview {
    SpendView(
        viewModel: .mock()
    )
}
