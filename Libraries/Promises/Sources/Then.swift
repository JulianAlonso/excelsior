//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

public extension Promise {
    @discardableResult
    func then<NewValue>(on queue: Queue = DispatchQueue.main,
                               _ mapValue: @escaping (T) throws -> NewValue) -> Promise<NewValue, E> {
        map(
            on: queue,
            mapValue: { Promise<NewValue, E>(value: try mapValue($0)) },
            mapError: { Promise<NewValue, E>(error: $0) }
        )
    }
    
    func then(on queue: Queue = DispatchQueue.main,
              _ runValue: @escaping (T) -> Void) -> Promise<T, E> {
        map(
            on: queue,
            mapValue: {
                runValue($0)
                return Promise<T, E>(value: $0)
            },
            mapError: { Promise<T, E>(error: $0) }
        )
    }
}
