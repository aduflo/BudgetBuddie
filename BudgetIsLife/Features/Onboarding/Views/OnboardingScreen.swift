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
        VStack(
            spacing: Spacing.2
        ) {
            AppIconView()
            
            ScrollView(.vertical) {
                Text(Copy.onboardingDescription)
                    .font(.body)
                    .foregroundStyle(.foregroundPrimary)
                    .padding(.bottom, Padding.4)
            }
            .scrollIndicators(.hidden)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .padding(.top, Padding.3)
        .padding(.horizontal, Padding.3)
        .ignoresSafeArea(.container, edges: .bottom)
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
