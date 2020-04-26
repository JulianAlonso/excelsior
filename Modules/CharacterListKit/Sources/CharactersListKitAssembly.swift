//
//  CharactersListKitAssembly.swift
//  CharactersListKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import NavigatorKit
import UIKit
import DisplayKit
import Core
import Support
import Injection

public final class CharacterListContainerModuleBuilder: ModuleBuilder<UIViewController> {
    private let storyboard = "CharactersListContainer"
    private let viewController = "CharactersListContainerViewController"
    
    public override func component() -> Component? {
        Component {
            factory { GCDScheduler(dispatchQueue: DispatchQueue.main, name: "main") as Scheduler}
            factory { GetCharacters(characterRepository: $0(), mainThreadScheduler: $0()) as GetCharactersProtocol }
            factory { CharactersListContainerPresenter(getCharacters: $0()) }
        }
    }
    
    public override func build() -> UIViewController {
        let bundle = Bundle(for: CharactersListContainerViewController.self)
        let storyboard = UIStoryboard(name: self.storyboard, bundle: bundle)
        guard let list = storyboard.instantiateViewController(withIdentifier: viewController) as? CharactersListContainerViewController  else {
            fatalError("Can't create charactersListContainerVC from storyboard")
        }
        
        list.charactersListContainerPresenter = module.resolve()
        
        return list
    }
    
}
