//
//  CharacterRepository.swift
//  DataProviders
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import Support

public protocol CharacterRepository: AnyObject {
    func characters(offset: Int?, completion: @escaping Done<[Character], CharacterRepositoryError>)
    func character(with id: Int, completion: @escaping Done<Character, CharacterRepositoryError>)
}

class InternalCharacterRepository {
    
    let characterService: CharacterServicing
    
    init(characterService: CharacterServicing) {
        self.characterService = characterService
    }
}

extension InternalCharacterRepository: CharacterRepository{
    func characters(offset: Int?, completion: @escaping Done<[Character], CharacterRepositoryError>) {
        characterService.characters(offset: offset, completion: completion)
    }
    
    func character(with id: Int, completion: @escaping Done<Character, CharacterRepositoryError>) {
        characterService.character(with: id, completion: completion)
    }
}
