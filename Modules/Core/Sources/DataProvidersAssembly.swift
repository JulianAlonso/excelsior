//
//  DataProvidersAssembly.swift
//  DataProviders
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import MarvelClient

public class DataProvidersAssembly {
    
    private let characterProvider: CharacterProviding
    
    public init(characterProvider: CharacterProviding) {
        self.characterProvider = characterProvider
    }
    
    public lazy var charactersRepository: CharacterRepository = InternalCharacterRepository(characterService: characterServicing)
    public lazy var characterServicing: CharacterServicing = CharacterService(provider: characterProvider)
}
