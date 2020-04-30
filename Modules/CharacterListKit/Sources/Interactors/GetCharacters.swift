//
//  GetCharacters.swift
//  CharactersListKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import Core
import Support
import Promises

/// GetCharacters returns in the **main thread** the characters with the properties inditated in the params
/// Also make all transformations between data layer models and presentation models
/// For this example the mapping is quite simple, mostly one to one.
/// - Character -> CharacterLisrModel
/// - CharacterRepositoryError -> CharacterListError
protocol GetCharactersProtocol: AnyObject {
    func execute(offset: Int?) -> Promise<[CharacterListModel], CharacterListError>
}

class GetCharacters{
    let characterRepository: CharacterRepository
    let mainThreadScheduler: Scheduler
    
    init(characterRepository: CharacterRepository,
         mainThreadScheduler: Scheduler) {
        self.characterRepository = characterRepository
        self.mainThreadScheduler = mainThreadScheduler
    }
}

extension GetCharacters: GetCharactersProtocol {
    func execute(offset: Int?) -> Promise<[CharacterListModel], CharacterListError> {
        characterRepository.characters(offset: offset)
            .then { $0.map { CharacterListModel(with: $0) } }
            .catch { CharacterListError(characterRepositoryError: $0) }
    }
}
