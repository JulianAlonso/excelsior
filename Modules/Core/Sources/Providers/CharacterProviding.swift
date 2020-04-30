//
//  CharacterProviding.swift
//  Core
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Support
import Promises

public protocol CharacterProviding {
    func characters(offset: Int?) -> Promise<[Character], CharacterRepositoryError>
    func character(by id: Int) -> Promise<Character, CharacterRepositoryError>
}
