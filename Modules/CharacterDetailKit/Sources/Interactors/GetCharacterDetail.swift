//
//  GetCharacterDetail.swift
//  CharacterDetailKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import Core
import Support

/// GetCharacterDetail returns in the **main thread** the details of a character given their ID
/// Also make all transformations between data layer models and presentation models
/// For this example the mapping is quite simple, mostly one to one.
/// - Character -> CharacterDetail
/// - CharacterRepositoryError -> CharacterDetailError
protocol GetCharacterDetailProtocol: AnyObject {
    func execute(with id: CharacterId, completion: @escaping Done<CharacterDetail, CharacterDetailError>)
}

final class GetCharacterDetail {
    let characterRepository: CharacterRepository
    
    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }
}

extension GetCharacterDetail: GetCharacterDetailProtocol {
    func execute(with id: CharacterId, completion: @escaping Done<CharacterDetail, CharacterDetailError>) {
        characterRepository.character(with: id) { result in
            switch result {
            case .success(let character):
                completion(.success(CharacterDetail(with: character)))
            case .failure(let repoError):
                completion(.failure(CharacterDetailError(characterRepositoryError: repoError)))
            }
        }
    }
}
