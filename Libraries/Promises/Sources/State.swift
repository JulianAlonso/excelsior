//
//  File.swift
//  
//
//  Created by Juli Alonso on 19/04/2020.
//

import Foundation

enum State<Value, E: Error> {

    case pending()

    case fulfilled(value: Value)

    case rejected(error: E)

}

extension State {
    var isPending: Bool {
        if case .pending = self {
            return true
        } else {
            return false
        }
    }
    
    var isFulfilled: Bool {
        if case .fulfilled = self {
            return true
        } else {
            return false
        }
    }
    
    var isRejected: Bool {
        if case .rejected = self {
            return true
        } else {
            return false
        }
    }
    
    var value: Value? {
        if case let .fulfilled(value) = self {
            return value
        }
        return nil
    }
    
    var error: E? {
        if case let .rejected(error) = self {
            return error
        }
        return nil
    }

}
