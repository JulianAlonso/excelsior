//
//  AppDelegate.swift
//  excelsior
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import UIKit
import NavigatorKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigator: Navigator

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setUpAppDelegateDependencies()
        setUpWindow()
        
        return true
    }
    
}

private extension AppDelegate {
  
    func setUpAppDelegateDependencies() {
        if AppCoreKitAssembly.current == nil {
            AppCoreKitAssembly.current = AppCoreKitAssembly()
        }
        let appCoreKitAssembly = AppCoreKitAssembly.current!
        
        appLaunchCoordinator = appCoreKitAssembly.appLaunchCoordinator
    }
    
    func setUpWindow() {
        window = AppCoreKitAssembly.window
        window!.frame = UIScreen.main.bounds
    }
    
}


