//
//  Authorization.swift
//  MarvelClient
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Networking

public struct Authorization {
    public let publicKey: String
    public let privateKey: String
    
    public init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
}

private extension Authorization {
    var parameters: [String: String] {
        let timeStamp = "\(Date().timeIntervalSince1970)"
        return [
            "apikey": publicKey,
            "hash": "\(timeStamp)\(privateKey)\(publicKey)".md5,
            "ts": timeStamp
        ]
    }
}

extension Authorization: Authorizating {
    public func authorize(endpoint: Endpoint) -> Endpoint {
        endpoint.adding(parameters: parameters)
    }
}
