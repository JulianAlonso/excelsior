//
//  Components.swift
//  App
//
//  Created by Juli Alonso on 25/04/2020.
//

import Foundation
import Injection
import Networking
import MarvelClient
import Core

let marvelComponent = Component {
    factory { Authorization(publicKey: Environment.publicKey, privateKey: Environment.privateKey) as Authorizating }
    single { HTTPClient(host: Environment.host, session: .shared, authorization: $0()) as HTTPPerforming }
    factory { CharacterService(client: $0()) as CharacterServicing }
    factory { CharacterProvider(service: $0()) as CharacterProviding }
}

