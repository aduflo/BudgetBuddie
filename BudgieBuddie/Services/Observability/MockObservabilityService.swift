//
//  MockObservabilityService.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/29/26.
//

import Foundation

struct MockObservabilityService: ObservabilityServiceable {
    static func start() {}
    static func forceCrash() {}
}
