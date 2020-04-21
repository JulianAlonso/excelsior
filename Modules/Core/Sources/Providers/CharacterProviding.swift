//
//  CharacterProviding.swift
//  Core
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Support

public protocol CharacterProviding {
    func characters(offset: Int?, _ done: @escaping Done<[Character], CharacterRepositoryError>)
    func character(by id: Int, _ done: @escaping Done<Character, CharacterRepositoryError>)
}
