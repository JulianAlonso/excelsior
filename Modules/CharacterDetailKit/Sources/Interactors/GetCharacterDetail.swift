//
//  GetCharacterDetail.swift
//  CharacterDetailKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import DataProvidersKit
import Support

/// GetCharacterDetail returns in the **main thread** the details of a character given their ID
/// Also make all transformations between data layer models and presentation models
/// For this example the mapping is quite simple, mostly one to one.
/// - Character -> CharacterDetail
/// - CharacterRepositoryError -> CharacterDetailError
protocol GetCharacterDetailProtocol: AnyObject {
    func execute(with id: CharacterId,
                 completion: @escaping (Result<CharacterDetail, CharacterDetailError>) -> Void)
}

class GetCharacterDetail{
    let characterRepository: CharacterRepository
    let mainThreadScheduler: Scheduler
    
    init(characterRepository: CharacterRepository,
         schedulerFactory: SchedulerFactory) {
        self.characterRepository = characterRepository
        mainThreadScheduler = schedulerFactory.mainThreadScheduler
    }
}

extension GetCharacterDetail: GetCharacterDetailProtocol {
    func execute(with id: CharacterId,
                 completion: @escaping (Result<CharacterDetail, CharacterDetailError>) -> Void) {
        characterRepository.character(with: id) { [weak self] result in
            self?.mainThreadScheduler.scheduleAsync {
                switch result {
                case .success(let character):
                    completion(.success(CharacterDetail(with: character)))
                case .failure(let repoError):
                    completion(.failure(CharacterDetailError(characterRepositoryError: repoError)))
                }
            }
        }
    }
}
