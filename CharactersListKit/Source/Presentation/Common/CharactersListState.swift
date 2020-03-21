//
//  CharactersListState.swift
//  CharactersListKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import CommonUIKit

enum CharactersListState {
    case loading(String)
    #warning("TODO: WIP")
    case charactersList([Any])
    case loadError(title: String, description: String, delegate: RetryViewControllerDelegate)
}
