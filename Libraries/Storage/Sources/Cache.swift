//
//  File.swift
//  
//
//  Created by Juli Alonso on 27/04/2020.
//

import Foundation

public final class MemoryCache {
    private let cache = NSCache<WrappedKey, Value>()
}

extension MemoryCache: Caching {
    public func set<T>(key: Key, value: T) {
        cache.setObject(Value(value), forKey: key.wrapped)
    }
    
    public func get<T>(key: Key) -> T? {
        cache.object(forKey: key.wrapped)?.value as? T
    }
}

extension MemoryCache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int { key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let wrapped = object as? WrappedKey else { return false }
            return self.key == wrapped.key
        }
    }
}

private extension Key {
    var wrapped: MemoryCache.WrappedKey { .init(self) }
}
