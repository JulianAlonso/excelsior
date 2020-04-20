//
//  CharacterProviding.swift
//  MarvelClient
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation
import Support
import Networking

public protocol CharacterProviding {
    func characters(_ done: Done<[ComicCharacter], MarvelError>)
    func character(by id: Int, _ done: Done<ComicCharacter, MarvelError>)
}

public final class CharacterProvider: CharacterProviding {
    
    private let client: HTTPPerforming
    
    init(client: HTTPPerforming) {
        self.client = client
    }
    
    public func characters(_ done: (Result<[ComicCharacter], MarvelError>) -> Void) {
        client.perform(Endpoint(path: "/v1/public/characters")) { (result: Result<Page<[ComicCharacter]>, Error<MarvelError>>) in
            
        }
    }
    
    public func character(by id: Int, _ done: (Result<ComicCharacter, MarvelError>) -> Void) {
        client.perform(Endpoint(path: "/v1/public/characters/\(id)")) { (result: Result<Page<[ComicCharacter]>, Error<MarvelError>>) in
            
        }
    }
    
}
