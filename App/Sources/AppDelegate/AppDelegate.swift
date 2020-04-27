//
//  AppDelegate.swift
//  excelsior
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import UIKit
import NavigatorKit
import Injection
import CharacterListKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigator: Navigating = Navigator(window: window!)
        
        injectMe {
            component { marvelComponent }
            component { repositoryComponent }
            component { uiComponent }
            component { coordinatorsComponent }
            single { navigator }
        }
        
        navigator.handle(navigation: .root(.list))
        return true
    }
    
}
