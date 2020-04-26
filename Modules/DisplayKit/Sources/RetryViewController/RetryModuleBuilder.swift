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
    private let onRetry: RetryViewController.OnRetry
    
    public init(title: String, description: String, onRetry: @escaping RetryViewController.OnRetry) {
        self.title = title
        self.description = description
        self.onRetry = onRetry
    }
    
    public override func build() -> UIViewController {
        RetryViewController(title: title, descriptionText: description, onRetry: onRetry)
    }
}
