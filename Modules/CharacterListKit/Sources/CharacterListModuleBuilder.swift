//
//  CharacterListModuleBuilder.swift
//  CharacterListKit
//
//  Created by Juli Alonso on 26/04/2020.
//

import Foundation
import UIKit
import Injection
import NavigatorKit

final class CharacterListModuleBuilder: ModuleBuilder<UIViewController> {
    
    private let characters: [CharacterListModel]
    private let offset: Int
    private let delegate: CharactersListPresenterDelegate
    
    init(characters: [CharacterListModel], offset: Int, delegate: CharactersListPresenterDelegate) {
        self.characters = characters
        self.offset = offset
        self.delegate = delegate
    }
    
    override func component() -> Component? {
        Component {
            factory { CharactersListPresenter(characters: self.characters, coordinator: $0()) }
            factory { resolver in { CharacterListCellBinder(character: $0, dateFormatter: resolver()) } }
        }
    }
    
    override func build() -> UIViewController {
        let presenter = module.resolve() as CharactersListPresenter
        presenter.delegate = delegate
        return CharactersListViewController(charactersListPresenter: presenter, cellBinderProvider: module.resolve(), offset: offset)
    }
    
}

