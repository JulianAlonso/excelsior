//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

extension Dictionary {
    static func + (lhs: Dictionary, rhs: Dictionary) -> Dictionary { lhs.merging(rhs) { $1 } }
}
