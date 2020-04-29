//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

public struct Endpoint {
    let path: String
    private(set) var parameters: [String: Any]
    
    public init(path: String, parameters: [String: Any] = [:]) {
        self.path = path
        self.parameters = parameters
    }
}

public extension Endpoint {
    func adding(parameters: [String: Any]) -> Endpoint {
        .init(path: path, parameters: self.parameters + parameters)
    }
}

extension Endpoint {
    func encode(to host: URL) -> URL {
        let url = host.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        return components.url!
    }
}
