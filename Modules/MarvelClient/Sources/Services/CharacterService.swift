//
//  CharacterService.swift
//  MarvelClient
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Support
import Networking
import Core

public protocol CharacterServicing {
    func characters(offset: Int?, _ done: @escaping (Result<[Character], MarvelError>) -> Void)
    func character(by id: Int, _ done: @escaping (Result<[Character], MarvelError>) -> Void)
}

public final class CharacterService: CharacterServicing {
    
    private let client: HTTPPerforming
    
    init(client: HTTPPerforming) {
        self.client = client
    }
    
    public func characters(offset: Int?, _ done: @escaping (Result<[Character], MarvelError>) -> Void) {
        client.perform(Endpoint(path: "/v1/public/characters", parameters: ["offset": offset ?? 0])) { (result: Result<Response<[Character]>, Error<MarvelError>>) in
            done(result.map(\.body.results).mapTerror(\.marvelError))
        }
    }
    
    public func character(by id: Int, _ done: @escaping (Result<[Character], MarvelError>) -> Void) {
        client.perform(Endpoint(path: "/v1/public/characters/\(id)")) { (result: Result<Response<[Character]>, Error<MarvelError>>) in
            done(result.map(\.body.results).mapTerror(\.marvelError))
        }
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
