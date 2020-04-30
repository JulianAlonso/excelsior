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
import Promises

public final class CharacterProvider: CharacterProviding {
    
    private let service: CharacterServicing
    
    public init(service: CharacterServicing) {
        self.service = service
    }
    
    public func characters(offset: Int?) -> Promise<[Core.Character], CharacterRepositoryError> {
        service.characters(offset: offset)
            .then { $0.map(\.coreCharacter) }
            .catch { $0.repositoryError }
    }
    
    public func character(by id: Int) -> Promise<Core.Character, CharacterRepositoryError> {
        service.character(by: id)
            .then { try $0.first.map(\.coreCharacter) ?? CharacterRepositoryError.notFound }
            .catch { $0.repositoryError }
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
