//
//  MockUserDefaultsService.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation

class MockUserDefaultsService: UserDefaultsServiceable {
    private var sourceDict: [String: Any] = [:]
    
    func set(_ value: Any?, forKey key: String) {
        sourceDict[key] = value
    }
    
    func bool(forKey key: String) -> Bool {
        sourceDict[key] as? Bool ?? false
    }
    
    func double(forKey key: String) -> Double {
        sourceDict[key] as? Double ?? 0.0
    }
    
    func integer(forKey key: String) -> Int {
        sourceDict[key] as? Int ?? 0
    }
}
