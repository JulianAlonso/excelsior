//
//  Navigator.swift
//  NavigatorKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import UIKit
import Support
public protocol Navigator {
    func handle(navigation: Navigation, animated: Bool)
}

public extension Navigator {
    func handle(navigation: Navigation) {
        handle(navigation: navigation, animated: true)
    }
}

final class InternalNavigator: Navigator {
    private let window: UIWindow
    private var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func handle(navigation: Navigation, animated: Bool = true) {
        switch navigation {
        case let .root(screen):
            setRootScreen(screen)
        case let .present(screen):
            presentationViewController.present(
                screen.build(),
                animated: animated
            )
        case let .push(screen):
            navigationController.pushViewController(
                screen.build(),
                animated: animated
            )
        }
    }
}

private extension InternalNavigator {
    func setRootScreen(_ screen: Screen) {
        navigationController = UINavigationController(rootViewController: screen.build())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    var presentationViewController: UIViewController {
        guard let vc = navigationController.visibleViewController ??
            navigationController.topViewController ??
            navigationController.viewControllers.last
            else {
            fatalError("Navigator with empty NavigationController")
        }
        return vc
    }
}
