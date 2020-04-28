//
//  File.swift
//  
//
//  Created by Juli Alonso on 27/04/2020.
//

import Foundation

public final class Key: Hashable {
    
    private let key: String
    
    public init(_ key: String) {
        self.key = key
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    public static func == (lhs: Key, rhs: Key) -> Bool {
        lhs.key == rhs.key
    }
}


final class Value {
    let value: Any
    
    init(_ value: Any) {
        self.value = value
    }
}
