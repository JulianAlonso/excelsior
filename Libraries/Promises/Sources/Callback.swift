//
//  File.swift
//  
//
//  Created by Juli Alonso on 19/04/2020.
//

import Foundation

struct Callback<T, E: Error> {
    
    private let queue: Queue
    private let onFulfill: Fulfill<T>
    private let onReject: Reject<E>
    
    init(on queue: Queue, fulfill: @escaping Fulfill<T>, reject: @escaping Reject<E>) {
        self.queue = queue
        self.onFulfill = fulfill
        self.onReject = reject
    }
    
    func fulfill(_ value: T, _ completion: @escaping () -> Void = {}) {
        queue.execute {
            self.onFulfill(value)
            completion()
        }
    }
    
    func reject(_ error: E, _ completion: @escaping () -> Void = {}) {
        queue.execute {
            self.onReject(error)
            completion()
        }
    }
    
}
