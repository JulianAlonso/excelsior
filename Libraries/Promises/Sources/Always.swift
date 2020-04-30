//
//  File.swift
//  
//
//  Created by Juli Alonso on 30/04/2020.
//

import Foundation

public extension Promise {
    
    @discardableResult
    func always(on queue: Queue = DispatchQueue.main,
                _ do: @escaping () -> Void) -> Promise<T, E> {
        map(
            on: queue,
            mapValue: {
                `do`()
                return Promise(value: $0)
            },
            mapError: {
                `do`()
                return Promise(error: $0)
            }
        )
    }
    
}
