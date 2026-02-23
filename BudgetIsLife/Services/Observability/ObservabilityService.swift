//
//  ObservabilityService.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/29/26.
//

import Foundation
import Firebase

struct ObservabilityService: ObservabilityServiceable {
    static func start() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    static func forceCrash() {
        Task {
            print("\(String(describing: Self.self)).\(#function): crashing in 3")
            try await Task.sleep(for: .seconds(3))
            print("\(String(describing: Self.self)).\(#function): triggering crash")
            fatalError("Crash was triggered")
        }
    }
}
