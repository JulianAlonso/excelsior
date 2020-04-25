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

public final class InternalCharacterRepository {
    let provider: CharacterProviding
    
    public init(provider: CharacterProviding) {
        self.provider = provider
    }
}

extension InternalCharacterRepository: CharacterRepository {
    public func characters(offset: Int?, completion: @escaping Done<[Character], CharacterRepositoryError>) {
        provider.characters(offset: offset, completion)
    }
    
    public func character(with id: Int, completion: @escaping Done<Character, CharacterRepositoryError>) {
        provider.character(by: id, completion)
    }
}
