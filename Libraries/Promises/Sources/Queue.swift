//
//  File.swift
//  
//
//  Created by Juli Alonso on 19/04/2020.
//

import Foundation

public protocol Queue {
    func execute(_ work: @escaping () -> Void)
}

extension DispatchQueue: Queue {
    public func execute(_ work: @escaping () -> Void) {
        async { work() }
    }
}
