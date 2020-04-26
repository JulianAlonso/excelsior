//
//  LoadingModuleBuilder.swift
//  DisplayKit
//
//  Created by Juli Alonso on 26/04/2020.
//

import Foundation
import Injection
import UIKit

public final class LoadingModuleBuilder: ModuleBuilder<UIViewController> {
    
    private let message: String
    
    public init(message: String) {
        self.message = message
    }
    
    public override func build() -> UIViewController {
        LoadingViewController(detailText: message)
    }
}

