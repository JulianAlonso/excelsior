//
//  Done.swift
//  Support
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation

public typealias Done<T, E: Error> = (Result<T, E>) -> Void
