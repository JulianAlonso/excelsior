//
//  File.swift
//  
//
//  Created by Juli Alonso on 27/04/2020.
//

import Foundation

public protocol Caching {
    func set<T>(key: String, value: T)
    func get<T>(key: String) -> T?
}
