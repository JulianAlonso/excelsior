//
//  CharactersListScreen.swift
//  CharactersListKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import NavigatorKit
import UIKit

public extension Screen {
    static func list() -> Screen {
        .init { CharacterListContainerModuleBuilder().build() }
    }
}
