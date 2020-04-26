//
//  RetryModuleBuilder.swift
//  DisplayKit
//
//  Created by Juli Alonso on 26/04/2020.
//

import Foundation
import UIKit
import Injection

public final class RetryModuleBuilder: ModuleBuilder<UIViewController> {
    private let title: String
    private let description: String
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    public override func build() -> UIViewController {
        RetryViewController(title: title, descriptionText: description)
    }
}
