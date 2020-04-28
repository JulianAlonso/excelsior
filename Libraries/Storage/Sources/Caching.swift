//
//  File.swift
//  
//
//  Created by Juli Alonso on 27/04/2020.
//

import Foundation

public protocol Caching {
    func set<T>(key: Key, value: T)
    func get<T>(key: Key) -> T?
}

public extension Caching {
    func set<T>(value: T) where T: Identifiable {
        set(key: Key(id: value.id, class: T.self), value: value)
    }
    
    func get<T>(id: T.ID) -> T? where T: Identifiable {
        get(key: Key(id: id, class: T.self))
    }
}

private extension Key {
    convenience init<T>(id: T.ID, class: T.Type) where T: Identifiable {
        self.init("\(type(of: T.self))\(id)")
    }
}
