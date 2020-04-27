//
//  Coordinators.swift
//  App
//
//  Created by Juli Alonso on 27/04/2020.
//

import Foundation
import CharacterListKit
import CharacterDetailKit
import NavigatorKit

final class CharacterListCoordinator: Coordinator, CharacterListCoordinating {
    func characterDetail(id: Int) {
        navigator.handle(navigation: .push(.detail(character: id)))
    }
}
