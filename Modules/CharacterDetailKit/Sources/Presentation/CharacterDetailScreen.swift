//
//  CharacterDetailScreen.swift
//  CharacterDetailKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import NavigatorKit
import UIKit

public extension Screen {
    static func detail(assembly: CharacterDetailKitAssembly,
                       character id: CharacterId) -> Screen {
        .init { assembly.characterDetailContainerViewController(characterId: id) }
    }
}
