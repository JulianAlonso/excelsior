//
//  File.swift
//  
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation

public protocol HTTPPerforming {
    func perform<T: Decodable, E: Decodable>(_ endpoint: Endpoint, completion: @escaping Callback<T, Error<E>>)
}
