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

extension Screen {
    static func detail(provider: CharacterDetailContainerViewControllerProvider,
                       character id: CharacterId) -> Screen {
        .init { provider.characterDetailContainerViewController(characterId: id) }
    }
}
