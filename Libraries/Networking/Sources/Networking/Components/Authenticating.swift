//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

public protocol Authorizating {
    func authorize(endpoint: Endpoint) -> Endpoint
}
