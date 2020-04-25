//
//  CharactersListPresenter.swift
//  CharactersListKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import DisplayKit
import NavigatorKit

protocol CharactersListPresenterDelegate: AnyObject {
    func loadMore()
}

/// CharactersListPresenter is the presenter for the list of characters
final class CharactersListPresenter {
    private let characters: [CharacterListModel]
    
    weak var delegate: CharactersListPresenterDelegate?
    
    private let detailNavigation: (Int) -> Void
    
    init(characters: [CharacterListModel],
         detailNavigation: @escaping (Int) -> Void) {
        self.characters = characters
        self.detailNavigation = detailNavigation
    }
}

extension CharactersListPresenter {
    
    var numberOfCharacters: Int {
        characters.count
    }
    
    func character(for index: Int) -> CharacterListModel {
        if index == characters.count - 1 {
            delegate?.loadMore()
        }
        
        return characters[index]
    }
        
    func characterSelected(at index: Int) {
        let character = characters[index]
        detailNavigation(character.id)
    }
}

