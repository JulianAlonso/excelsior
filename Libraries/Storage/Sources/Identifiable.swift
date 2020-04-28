//
//  File.swift
//  
//
//  Created by Juli Alonso on 28/04/2020.
//

import Foundation

public protocol Identifiable {

    associatedtype ID : Hashable

    var id: Self.ID { get }
}
