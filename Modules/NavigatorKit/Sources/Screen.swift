//
//  Screen.swift
//  NavigatorKit
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation
import UIKit

public struct Screen {
    public let build: () -> UIViewController
    
    public init(_ builder: @escaping () -> UIViewController) {
        self.build = builder
    }
}
