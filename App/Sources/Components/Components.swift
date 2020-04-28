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
import CharacterListKit
import Storage

let marvelComponent = Component {
    factory { Authorization(publicKey: Environment.publicKey, privateKey: Environment.privateKey) as Authorizating }
    single { HTTPClient(host: Environment.host, session: .shared, authorization: $0()) as HTTPPerforming }
    factory { CharacterService(client: $0()) as CharacterServicing }
    factory { CharacterProvider(service: $0()) as CharacterProviding }
}

let storageComponent = Component {
    single { MemoryCache() as Caching }
}

let repositoryComponent = Component {
    factory { InternalCharacterRepository(provider: $0(), cache: $0()) as CharacterRepository }
}

let coordinatorsComponent = Component {
    factory { CharacterListCoordinator(navigator: $0()) as CharacterListCoordinating }
}

let uiComponent = Component {
    single { dateFormatter }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM yyyy"
    formatter.locale = .current
    
    return formatter
}()
