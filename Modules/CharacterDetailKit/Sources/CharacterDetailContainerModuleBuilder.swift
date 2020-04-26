//
//  CharacterDetailKitAssembly.swift
//  CharacterDetailKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import NavigatorKit
import UIKit
import DisplayKit
import Core
import Support
import Injection

public final class CharacterDetailContainerModuleBuilder: ModuleBuilder<UIViewController> {
    private let storyboard = "CharacterDetailContainer"
    private let viewController = "CharacterDetailContainerViewController"
    private let characterId: CharacterId
    
    public init(characterId: CharacterId) {
        self.characterId = characterId
    }
    
    public override func component() -> Component? {
        Component {
            factory { GetCharacterDetail(characterRepository: $0()) }
            factory { CharacterDetailContainerViewModel(state: .loading("Initial"), getCharacterDetail: $0(), characterId: self.characterId) }
        }
    }
    
    public override func build() -> UIViewController {
        let bundle = Bundle(for: CharacterDetailContainerViewController.self)
        let storyboard = UIStoryboard(name: self.storyboard, bundle: bundle)
        guard let detail = storyboard.instantiateViewController(withIdentifier: viewController) as? CharacterDetailContainerViewController  else {
            fatalError("Can't create characterDetailContainerVC from storyboard")
        }
        let viewModel: CharacterDetailContainerViewModel = module.resolve()
        detail.viewModel = AnyViewModel(viewModel: viewModel)
        viewModel.subscribe(view: detail)
        return detail
    }
    
}

public extension Screen {
    static func detail(character id: CharacterId) -> Screen {
        .init { CharacterDetailContainerModuleBuilder(characterId: id).build() }
    }
}
