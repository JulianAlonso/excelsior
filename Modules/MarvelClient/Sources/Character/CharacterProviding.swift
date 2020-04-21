//
//  CharacterProviding.swift
//  MarvelClient
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Support
import Networking

public protocol CharacterProviding {
    func characters(offset: Int?, _ done: @escaping Done<[Character], MarvelError>)
    func character(by id: Int, _ done: @escaping Done<[Character], MarvelError>)
}

public final class CharacterProvider: CharacterProviding {
    
    private let client: HTTPPerforming
    
    init(client: HTTPPerforming) {
        self.client = client
    }
    
    public func characters(offset: Int?, _ done: @escaping (Result<[Character], MarvelError>) -> Void) {
        client.perform(Endpoint(path: "/v1/public/characters", parameters: ["offset": offset ?? 0])) { (result: Result<Page<[Character]>, Error<MarvelError>>) in
            done(result.map(\.results).mapTerror(\.marvelError))
        }
    }
    
    public func character(by id: Int, _ done: @escaping (Result<[Character], MarvelError>) -> Void) {
        client.perform(Endpoint(path: "/v1/public/characters/\(id)")) { (result: Result<Page<[Character]>, Error<MarvelError>>) in
            done(result.map(\.results).mapTerror(\.marvelError))
        }
    }
    
}


extension Error where T == MarvelError {
    var marvelError: MarvelError {
        switch self {
        case .known(_, let body): return body
        case .unkown(_, let error): return .underlying(error)
        case .underlying(let error): return .underlying(error)
        }
    }
}
