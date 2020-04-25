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

/// This is the assembly for the feature - Character detail.

public final class CharacterDetailKitAssembly {
    
    private let commonUIKit: CommonUIKitAssembly
    private let dataProviders: DataProvidersAssembly
    private let dateFormmater: DateFormatter
    private let mainNavigator: Navigator
    
    public init(commonUIKit: CommonUIKitAssembly,
                dataProviders: DataProvidersAssembly,
                dateFormmater: DateFormatter,
                mainNavigator: Navigator) {
        self.commonUIKit = commonUIKit
        self.dataProviders = dataProviders
        self.dateFormmater = dateFormmater
        self.mainNavigator = mainNavigator
    }

    func characterDetailContainerViewModel(for characterId: CharacterId) -> CharacterDetailContainerViewModel {
        CharacterDetailContainerViewModel(state: .loading("Initial"),
                                 getCharacterDetail: getCharacterDetail(),
                                 characterId: characterId)
    }
    
    func characterDetailViewControllerFactory() -> CharacterDetailViewControllerFactory {
        CharacterDetailViewControllerFactory(loadingViewControllerProvider: commonUIKit,
                                            retryViewControllerProvider: commonUIKit,
                                            characterDetailViewControllerProvider: self)
    }
    
    func getCharacterDetail() -> GetCharacterDetail {
        GetCharacterDetail(characterRepository: dataProviders.charactersRepository)
    }
    
    func detailViewModel(_ detail: CharacterDetail) -> ViewModel<CharacterDetailDisplayModel, Never> {
        CharacterDetailViewModel(state: detail.displayModel)
    }
    
}


extension CharacterDetailKitAssembly: CharacterDetailContainerViewControllerProvider {
    func characterDetailContainerViewController(characterId: CharacterId) -> CharacterDetailContainerViewController {
        let bundle = Bundle(for: CharacterDetailContainerViewController.self)
        
        let storyboard = UIStoryboard(name: CharacterDetailContainerViewController.storyboard, bundle: bundle)
        return CharacterDetailContainerViewController.createWith(storyboard: storyboard,
                                                                 viewModel: AnyViewModel(viewModel: characterDetailContainerViewModel(for: characterId)),
                                                                 characterDetailViewControllerFactory: characterDetailViewControllerFactory())
    }
}

extension CharacterDetailKitAssembly: CharacterDetailViewControllerProvider {
    func characterDetailViewController(character: CharacterDetail) -> CharacterDetailViewController {
        CharacterDetailViewController(viewModel: AnyViewModel(viewModel: detailViewModel(character)))
    }
}

extension CharacterDetail {
    var displayModel: CharacterDetailDisplayModel {
        .init(name: name, bio: bio, image: thumbnailURL)
    }
}
