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
