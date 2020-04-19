//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

public extension Promise {
    @discardableResult
    func `catch`<NewError: Error>(on queue: Queue = DispatchQueue.main,
                                         _ mapError: @escaping (E) -> NewError) -> Promise<T, NewError> {
        map(
            on: queue,
            mapValue: { Promise<T, NewError>(value: $0) },
            mapError: { Promise<T, NewError>(error: mapError($0)) }
        )
    }
    
    @discardableResult
    func `catch`(on queue: Queue = DispatchQueue.main,
                 _ catch: @escaping (E) -> Void) -> Promise<T, E> {
        then(on: queue, fulfill: { _ in }, reject: `catch`)
    }
}
