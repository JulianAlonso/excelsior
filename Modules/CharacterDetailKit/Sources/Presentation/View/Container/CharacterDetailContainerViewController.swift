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

enum CharacterDetailState {
    case loading(String)
    case loaded(CharacterDetail)
    case loadError(title: String, description: String)
}

enum CharacterDetailAction {
    case load
}

final class CharacterDetailContainerViewController: UIViewController {
    static let storyboard = "CharacterDetailContainer"
    static let viewController = "CharacterDetailContainerViewController"
    
    var viewModel: AnyViewModel<CharacterDetailState, CharacterDetailAction>?
    private var childViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.handle(.load)
    }
}

extension CharacterDetailContainerViewController: StatefulView {
    func render(state: CharacterDetailState) {
        let viewController = self.viewController(for: state)
        setContentViewController(viewController, in: view, withPreviousViewControler: childViewController)
        childViewController = viewController
    }
    
    private func viewController(for state: CharacterDetailState) -> UIViewController {
        switch state {
        case .loading(let detailText):
            return LoadingModuleBuilder(message: detailText).build()
        case .loaded(let characterDetail):
            return CharacterDetailModuleBuilder(detail: characterDetail).build()
        case let .loadError(title, description):
            return RetryModuleBuilder(title: title, description: description, onRetry: { self.viewModel?.handle(.load) }).build()
        }
    }
}
