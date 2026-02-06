//
//  OnboardingScreen.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/23/26.
//

import SwiftUI

struct OnboardingScreen: View {
    // Instance vars
    private let screenModel = OnboardingScreenModel()
    
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
            .scrollIndicators(.hidden)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .padding(Padding.3)
        .onAppear {
            screenModel.setDidOnboardOnce()
        }
    }
}

#Preview("Light Mode") {
    OnboardingScreen()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    OnboardingScreen()
        .preferredColorScheme(.dark)
}
