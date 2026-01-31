//
//  OnboardingView.swift
//  BudgieBuddie
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
            AppIcon()
            
            ScrollView(.vertical) {
                Text(Copy.onboardingDescription)
                    .font(.body)
                    .foregroundStyle(.foregroundPrimary)
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

#Preview("Light Mode") {
    OnboardingView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    OnboardingView()
        .preferredColorScheme(.dark)
}
