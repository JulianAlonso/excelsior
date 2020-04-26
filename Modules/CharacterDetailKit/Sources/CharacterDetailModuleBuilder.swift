//
//  CharacterDetailModuleBuilder.swift
//  CharacterDetailKit
//
//  Created by Juli Alonso on 26/04/2020.
//

import Foundation
import Injection
import UIKit
import DisplayKit

final class CharacterDetailModuleBuilder: ModuleBuilder<UIViewController> {
    
    private let detail: CharacterDetail
    
    init(detail: CharacterDetail) {
        self.detail = detail
    }
    
    override func component() -> Component? {
        Component {
            factory { CharacterDetailViewModel(state: self.detail.displayModel) as ViewModel<CharacterDetailDisplayModel, Never> }
        }
    }
    
    override func build() -> UIViewController {
        CharacterDetailViewController(viewModel: AnyViewModel(viewModel: module.resolve()))
    }
    
}

private extension CharacterDetail {
    var displayModel: CharacterDetailDisplayModel {
        .init(name: name, bio: bio, image: thumbnailURL)
    }
}
