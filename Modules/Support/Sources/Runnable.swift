//
//  Runnable.swift
//  Support
//
//  Created by Juli Alonso on 28/04/2020.
//

import Foundation

public protocol Runnable {}

public extension Runnable {
    @inlinable
    func run(_ work: (Self) -> Void) -> Self {
        work(self)
        return self
    }
}
