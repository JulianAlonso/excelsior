//
//  Optional+sugar.swift
//  Support
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation

public extension Optional {
    /// this could be remove if we have `some ?? throw error` available. but we dont ☹️
    static func ?? (optional: Self, error: Error) throws -> Wrapped {
        switch optional {
        case .some(let value): return value
        case .none: throw error
        }
    }
}
