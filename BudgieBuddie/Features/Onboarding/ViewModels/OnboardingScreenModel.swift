//
//  OnboardingScreenModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/23/26.
//

import Foundation

struct OnboardingScreenModel {}

// MARK: Public interface
extension OnboardingScreenModel {    
    func setDidOnboardOnce() {
        UserDefaults.standard.set(
            true,
            forKey: UserDefaults.Key.App.didOnboardOnce
        )
    }
}
