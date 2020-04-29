//
//  File.swift
//  
//
//  Created by Juli Alonso on 29/04/2020.
//

import Foundation
import Networking
import Promises

public extension HTTPPerforming {
    func perform<T: Decodable, E: Decodable>(_ endpoint: Endpoint) -> Promise<T, Error<E>> {
        Promise { future in
            self.perform(endpoint) { (result: Result<T, Error<E>>) in
                switch result {
                case .success(let value): future.fulfill(value)
                case .failure(let error): future.reject(error)
                }
            }
        }
    }
}
