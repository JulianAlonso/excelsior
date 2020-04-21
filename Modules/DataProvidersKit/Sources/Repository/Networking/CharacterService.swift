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
    func characters(nameStartsWith: String?, offset: Int?, completion: @escaping Done<[Character], CharacterRepositoryError>)
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
        provider.characters { result in
            switch result {
            case .success(let dataContainer):
                let networkCharacters = dataContainer.results
                guard networkCharacters.count != 0 else {
                    completion(.failure(.notFound))
                    return
                }
                
                let characters = networkCharacters.map { Character(withResponse: $0)}
                
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(CharacterRepositoryError(withResponseError: error)))
            }
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
