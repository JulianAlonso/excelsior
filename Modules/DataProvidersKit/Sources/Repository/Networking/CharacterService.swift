//
//  CharacterService.swift
//  Models
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import MarvelClient
import Support

protocol CharacterServicing: AnyObject {
    func characters(offset: Int?, completion: @escaping Done<[Character], CharacterRepositoryError>)
    func character(with id: Int, completion: @escaping Done<Character, CharacterRepositoryError>)
}

final class CharacterService {
    let provider: CharacterProviding
    
    init(provider: CharacterProviding) {
        self.provider = provider
    }
}

extension CharacterService: CharacterServicing {
    func characters(offset: Int?, completion: @escaping Done<[Character], CharacterRepositoryError>) {
        provider.characters(offset: offset) { result in
            completion(result
                .map { $0.map { Character(withResponse: $0) } }
                .mapTerror(\.repositoryError)
            )
        }
    }
    
    func character(with id: Int, completion: @escaping Done<Character, CharacterRepositoryError>) {
        let request = GetCharacter(characterId: id)
        apiClient.send(request) { response in
            switch response {
            case .success(let dataContainer):
                let networkCharacters = dataContainer.results
                guard let networkCharacter = networkCharacters.first else {
                    completion(.failure(.notFound))
                    return
                }
                let character = Character(withResponse: networkCharacter)
                
                completion(.success(character))
            case .failure(let error):
                completion(.failure(CharacterRepositoryError(withResponseError: error)))
            }
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
