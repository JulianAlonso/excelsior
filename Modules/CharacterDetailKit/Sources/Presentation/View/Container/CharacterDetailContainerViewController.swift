//
//  CharacterDetailContainerViewController.swift
//  CharacterDetailKit
//
//  Created by Rafael Bartolome on 22/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import UIKit
import DisplayKit

protocol CharacterDetailContainerViewControllerProvider: class {
    func characterDetailContainerViewController(characterId: CharacterId) -> CharacterDetailContainerViewController
}

enum CharacterDetailState {
    case loading(String)
    case loaded(CharacterDetail)
    case loadError(title: String, description: String, delegate: RetryViewControllerDelegate)
}

enum CharacterDetailAction {
    case load
}

final class CharacterDetailContainerViewController: UIViewController {
    static let storyboard = "CharacterDetailContainer"
    static let viewController = "CharacterDetailContainerViewController"
    
    private var viewModel: AnyViewModel<CharacterDetailState, CharacterDetailAction>?
    private var childViewController: UIViewController?
    private var characterDetailViewControllerFactory: CharacterDetailViewControllerFactory!
    
    static func createWith(storyboard: UIStoryboard,
                           viewModel: AnyViewModel<CharacterDetailState, CharacterDetailAction>,
                           characterDetailViewControllerFactory: CharacterDetailViewControllerFactory) -> CharacterDetailContainerViewController {
        guard let characterDetailContainerVC = storyboard.instantiateViewController(withIdentifier: CharacterDetailContainerViewController.viewController) as? CharacterDetailContainerViewController  else {
            fatalError("Can't create characterDetailContainerVC from storyboard")
        }
        
        // setup dependencies
        characterDetailContainerVC.viewModel = viewModel
        characterDetailContainerVC.characterDetailViewControllerFactory = characterDetailViewControllerFactory
        viewModel.subscribe(view: characterDetailContainerVC)
        
        return characterDetailContainerVC
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.handle(.load)
    }
}

extension CharacterDetailContainerViewController: StatefulView {
    func render(state: CharacterDetailState) {
        let viewController = characterDetailViewControllerFactory.viewController(forState: state)
        setContentViewController(viewController,
                                 in: view,
                                 withPreviousViewControler: childViewController)
        childViewController = viewController
    }
}
