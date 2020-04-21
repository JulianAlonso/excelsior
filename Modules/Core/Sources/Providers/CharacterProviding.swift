//
//  CharacterProviding.swift
//  Core
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation

public protocol CharacterProviding {
    func characters(offset: Int?, _ done: @escaping Done<[Character], MarvelError>)
    func character(by id: Int, _ done: @escaping Done<[Character], MarvelError>)
}
