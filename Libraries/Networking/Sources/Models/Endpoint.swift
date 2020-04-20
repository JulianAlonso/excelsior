//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

public struct Endpoint {
    let endpoint: String
    var paramters: [String: Any]
}

extension Endpoint {
    func encode(to host: URL) -> URL {
        let url = host.appendingPathComponent(endpoint)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = paramters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        return components.url!
    }
}
