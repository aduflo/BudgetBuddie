//
//  MockUserDefaultsService.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation

class MockUserDefaultsService: UserDefaultsServiceable {
    private var sourceDict: [String: Any] = [:]
    
    func set(_ value: Any?, forKey key: UserDefaultsKey) {
        sourceDict[key.value] = value
    }
    
    func bool(forKey key: UserDefaultsKey) -> Bool {
        sourceDict[key.value] as? Bool ?? false
    }
    
    func double(forKey key: UserDefaultsKey) -> Double {
        sourceDict[key.value] as? Double ?? 0.0
    }
    
    func integer(forKey key: UserDefaultsKey) -> Int {
        sourceDict[key.value] as? Int ?? 0
    }
}
