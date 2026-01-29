//
//  MockObservabilityService.swift
//  BirdsEye
//
//  Created by Adam Duflo on 1/29/26.
//

import Foundation

struct MockObservabilityService: ObservabilityServiceable {
    static func start() {
        print("\(String(describing: Self.self)).\(#function)")
    }
    
    static func forceCrash() {
        print("\(String(describing: Self.self)).\(#function)")
    }
}
