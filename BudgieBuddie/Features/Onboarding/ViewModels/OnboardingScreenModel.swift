//
//  OnboardingScreenModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/23/26.
//

import Foundation

struct OnboardingScreenModel {
    // Instances vars
    let userDefaults: UserDefaultsServiceable
}

// MARK: Public interface
extension OnboardingScreenModel {    
    func setDidOnboardOnce() {
        userDefaults.set(
            true,
            forKey: UserDefaultsKey.App.didOnboardOnce
        )
    }
}
