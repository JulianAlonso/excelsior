//
//  Navigator.swift
//  NavigatorKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import UIKit

public enum Navigation {
    case root(Screen)
    case push(Screen)
    case present(Screen)
}

public struct Screen {
    public let build: () -> UIViewController
    
    public init(_ builder: @escaping () -> UIViewController) {
        self.build = builder
    }
}

public protocol Navigating {
    func handle(navigation: Navigation, animated: Bool)
}

public extension Navigating {
    func handle(navigation: Navigation) {
        handle(navigation: navigation, animated: true)
    }
}

public final class Navigator: Navigating {
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func handle(navigation: Navigation, animated: Bool = true) {
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

private extension Navigator {
    func setRootScreen(_ screen: Screen) {
        navigationController.viewControllers = [screen.build()]
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
