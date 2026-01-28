//
//  OnboardingViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/23/26.
//

import Foundation

struct OnboardingViewModel {}

// MARK: Public interface
extension OnboardingViewModel {    
    func setDidOnboardOnce() {
        UserDefaults.standard.set(
            true,
            forKey: UserDefaults.Key.App.didOnboardOnce
        )
    }
}
