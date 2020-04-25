//
//  AppCoreKitAssembly.swift
//  AppCoreKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import NavigatorKit
import DisplayKit
import CharacterListKit
import CharacterDetailKit
import Core
import MarvelClient
import UIKit

public protocol AppCoreKitAssemblyProviderProtocol {
    func appCoreKitAssembly() -> AppCoreKitAssembly
}

/// This is the main assembly in charge of creating all dependencies for the App.
/// It's created in the AppDelegate when the app starts.

public final class AppCoreKitAssembly {
    
    static var current = AppCoreKitAssembly()
    let window = UIWindow(frame: UIScreen.main.bounds)

    // Setup navigation kit
    private lazy var navigatorKit = NavigatorKitAssembly(window: window)
    lazy var navigator = navigatorKit.navigator()
       
    // Setup Common UI kit
    private lazy var commonUIKit = CommonUIKitAssembly()
    
    // SetUp data providers
    private lazy var dataProviders = DataProvidersAssembly(characterProvider: marvelAPI.characterProvider)
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.locale = .current
        
        return formatter
    }()
    
    // SetUp Marvel API client
    private lazy var marvelAPI = MarvelClientAssembly()

    // SetUp first feature framework - Characters list
    lazy var charactersListKit = CharactersListKitAssembly(commonUIKit: commonUIKit,
                                                                   dataProviders: dataProviders,
                                                                   dateFormmater: dateFormatter,
                                                                   detailNavigation: { characterId in
                                                                    self.navigator.handle(navigation: .push(.detail(assembly: self.characterDetailKit,
                                                                                                                    character: characterId)))
                                                                    
    }
    )
    // SetUp second feature framework - Character detail
    private lazy var characterDetailKit = CharacterDetailKitAssembly(commonUIKit: commonUIKit,
                                                                   dataProviders: dataProviders,
                                                                   dateFormmater: dateFormatter,
                                                                   mainNavigator: navigator)
    
    private init() {}
    
}
