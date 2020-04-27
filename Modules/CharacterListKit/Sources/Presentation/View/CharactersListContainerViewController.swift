//
//  CharactersListContainerViewController.swift
//  CharactersListKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import UIKit
import DisplayKit


/// CharactersListContainerViewController is the container for all possible list states (loading, loaded or error)
/// Each list state is representer in a diferent view controller that is presented as a child view controller.
final class CharactersListContainerViewController: UIViewController {
    private var childViewController: UIViewController?
    
    var charactersListContainerPresenter: CharactersListContainerPresenter! {
        didSet {
           charactersListContainerPresenter.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        charactersListContainerPresenter.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension CharactersListContainerViewController: CharactersListContainerView {
    func showView(forState state: CharactersListState) {
        let viewController = self.viewController(for: state)
        setContentViewController(viewController,
                                 in: view,
                                 withPreviousViewControler: childViewController)
        childViewController = viewController
    }
    
    private func viewController(for state: CharactersListState) -> UIViewController {
        switch state {
        case .loading(let detailText):
            return LoadingModuleBuilder(message: detailText).build()
        case let .charactersList(characters, offset, delegate):
            return CharacterListModuleBuilder(characters: characters, offset: offset, delegate: delegate).build()
        case let .loadError(title, description):
            return RetryModuleBuilder(title: title, description: description, onRetry: { self.charactersListContainerPresenter.didLoad() }).build()
        }
    }
}    
