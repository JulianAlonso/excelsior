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

extension Screen {
    static func list(provider: CharactersListContainerViewControllerProvider) -> Screen {
        .init { provider.charactersListContainerViewController() }
    }
}
