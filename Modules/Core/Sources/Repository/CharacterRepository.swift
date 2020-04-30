//
//  CharacterRepository.swift
//  DataProviders
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import Support
import Storage
import Promises

public protocol CharacterRepository: AnyObject {
    func characters(offset: Int?) -> Promise<[Character], CharacterRepositoryError>
    func character(with id: Int) -> Promise<Character, CharacterRepositoryError>
}

public final class InternalCharacterRepository {
    let provider: CharacterProviding
    let cache: Caching
    
    public init(provider: CharacterProviding, cache: Caching) {
        self.provider = provider
        self.cache = cache
    }
}

extension InternalCharacterRepository: CharacterRepository {
    public func characters(offset: Int?) -> Promise<[Character], CharacterRepositoryError> {
        provider.characters(offset: offset).then {
            $0.forEach { self.cache.set(value: $0) }
        }
    }
    
    public func character(with id: Int) -> Promise<Character, CharacterRepositoryError> {
        if let character = cache.get(id: id as Character.ID) as Character? {
            return Promise(value: character)
        } else {
            return provider.character(by: id).then { self.cache.set(value: $0) }
        }
    }
}

extension Character: Identifiable {}
extension Array: Runnable {}
extension Character: Runnable {}
