//
//  OnboardingView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/23/26.
//

import SwiftUI

struct OnboardingView: View {
    // Instance vars
    private let viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(
            spacing: Spacing.2
        ) {
            AppIconIdea() // TODO: replace with app icon asset
            
            Text(Copy.onboardingExplanation)
                .font(.body)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
            
            Spacer() // to push everything to the top
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .padding(Padding.3)
        .onAppear {
            viewModel.setDidOnboardOnce()
        }
    }
}

#Preview {
    OnboardingView()
}
