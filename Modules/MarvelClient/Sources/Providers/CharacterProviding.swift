//
//  CharacterProviding.swift
//  MarvelClient
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Support
import Networking
import Core

public final class CharacterProvider: CharacterProviding {
    
    private let service: CharacterServicing
    
    public init(service: CharacterServicing) {
        self.service = service
    }
    
    public func characters(offset: Int?, _ done: @escaping Done<[Core.Character], CharacterRepositoryError>) {
        service.characters(offset: offset) { result in
            done(result
                .map { $0.map { $0.coreCharacter } }
                .mapTerror(\.repositoryError)
            )
        }
    }
    
    public func character(by id: Int, _ done: @escaping Done<Core.Character, CharacterRepositoryError>) {
        service.character(by: id) { result in
            done(result.tryMap(
                transformSuccess: { try $0.first.map { $0.coreCharacter } ?? CharacterRepositoryError.notFound },
                transformFailure: { $0.repositoryError })
            )
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
