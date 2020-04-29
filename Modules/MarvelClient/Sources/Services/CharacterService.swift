//
//  CharacterService.swift
//  MarvelClient
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Support
import Networking
import NetworkingPromises
import Promises
import Core

public protocol CharacterServicing {
    func characters(offset: Int?) -> Promise<[Character], MarvelError>
    func character(by id: Int) -> Promise<[Character], MarvelError>
}

public final class CharacterService: CharacterServicing {
    
    private let client: HTTPPerforming
    
    public init(client: HTTPPerforming) {
        self.client = client
    }
    
    public func characters(offset: Int?) -> Promise<[Character], MarvelError> {
        (client.perform(Endpoint(path: "/v1/public/characters", parameters: ["offset": offset ?? 0])) as Promise<Response<[Character]>, Error<MarvelError>>)
        .then { $0.body.results }
        .catch { $0.marvelError }
    }
    
    public func character(by id: Int) -> Promise<[Character], MarvelError> {
        (client.perform(Endpoint(path: "/v1/public/characters/\(id)")) as Promise<Response<[Character]>, Error<MarvelError>>)
            .then { $0.body.results }
            .catch { $0.marvelError }
    }
}

extension MarvelError {
    var repositoryError: CharacterRepositoryError {
        switch self {
        case .server(let code, let message): return .marvelError(code: code, message: message)
        case .underlying(let error): return .unknow(error)
        }
    }
}
