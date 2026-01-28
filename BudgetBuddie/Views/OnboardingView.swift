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
            Image(Asset.appIconSmall)
                .resizable()
                .frame(width: 72.0, height: 72.0)
            
            ScrollView(.vertical) {
                Text(Copy.onboardingExplanation)
                    .font(.body)
            }
            .scrollIndicators(.automatic)
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
