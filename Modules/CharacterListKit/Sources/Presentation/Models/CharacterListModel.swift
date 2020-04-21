//
//  CharacterListModel.swift
//  CharactersListKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import Core

struct CharacterListModel: Equatable {
    public let id: Int
    public let name: String
    public let thumbnailURL: URL?
    public let modified: Date
}

/// Mapper between data providers domain and presentation domain
extension CharacterListModel {
    init(with character: Character) {
        id = character.id
        name = character.name
        thumbnailURL = character.thumbnailURL
        modified = character.modified
    }
}
