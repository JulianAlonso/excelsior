//
//  File.swift
//  
//
//  Created by Juli Alonso on 19/04/2020.
//

import Foundation

public struct Future<T, E: Error> {
    
    public let fulfill: (T) -> Void
    public let reject: (E) -> Void
    
}
