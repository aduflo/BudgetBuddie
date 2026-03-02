//
//  OnboardingScreen.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/23/26.
//

import SwiftUI

struct OnboardingScreen: View {
    // Instance vars
    private let screenModel: OnboardingScreenModel
    
    // Constructors
    init(
        screenModel: OnboardingScreenModel
    ) {
        self.screenModel = screenModel
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(
                spacing: Spacing.2
            ) {
                AppIconView()
                
                Text(Copy.onboardingDescription)
                    .font(.body)
                    .foregroundStyle(.foregroundPrimary)
            }
            .padding(.top, Padding.3)
            .padding(.horizontal, Padding.3)
            .padding(.bottom, Padding.4)
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .onAppear {
            screenModel.setDidOnboardOnce()
        }
    }
}

#Preview("Light Mode") {
    OnboardingScreen(
        screenModel: OnboardingScreenModel(
            userDefaults: MockUserDefaultsService()
        )
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    OnboardingScreen(
        screenModel: OnboardingScreenModel(
            userDefaults: MockUserDefaultsService()
        )
    )
    .preferredColorScheme(.dark)
}
