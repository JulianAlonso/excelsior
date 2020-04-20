//
//  CharacterProviding.swift
//  MarvelClient
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Support

public protocol CharacterProviding {
    func characters(_ done: Done<[ComicCharacter], MarvelError>)
    func character(by id: Int, _ done: Done<ComicCharacter, MarvelError>)
}
