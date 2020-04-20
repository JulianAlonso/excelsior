//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

public struct Endpoint {
    let path: String
    private(set) var paramters: [String: Any]
}

public extension Endpoint {
    func adding(parameters: [String: Any]) -> Endpoint {
        .init(path: path, paramters: parameters + parameters)
    }
}

extension Endpoint {
    func encode(to host: URL) -> URL {
        let url = host.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = paramters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        return components.url!
    }
}
