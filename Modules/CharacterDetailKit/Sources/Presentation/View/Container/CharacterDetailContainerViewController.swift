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

final class CharacterDetailContainerViewController: UIViewController {
    static let storyboard = "CharacterDetailContainer"
    static let viewController = "CharacterDetailContainerViewController"
    
    private var childViewController: UIViewController?
    
    private var characterDetailContainerPresenter: CharacterDetailContainerPresenter! {
        didSet {
            characterDetailContainerPresenter.view = self
        }
    }
    private var characterDetailViewControllerFactory: CharacterDetailViewControllerFactory!
    
    static func createWith(storyboard: UIStoryboard,
                           characterDetailContainerPresenter: CharacterDetailContainerPresenter,
                           characterDetailViewControllerFactory: CharacterDetailViewControllerFactory) -> CharacterDetailContainerViewController {
        guard let characterDetailContainerVC = storyboard.instantiateViewController(withIdentifier: CharacterDetailContainerViewController.viewController) as? CharacterDetailContainerViewController  else {
            fatalError("Can't create characterDetailContainerVC from storyboard")
        }
        
        // setup dependencies
        characterDetailContainerVC.characterDetailContainerPresenter = characterDetailContainerPresenter
        characterDetailContainerVC.characterDetailViewControllerFactory = characterDetailViewControllerFactory
        
        return characterDetailContainerVC
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterDetailContainerPresenter.didLoad()
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
