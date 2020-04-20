//
//  ServerError.swift
//  MarvelClient
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

enum Error<T: Decodable>: Swift.Error {
    case known(code: Int, body: T)
    case unkown(code: Int, Swift.Error)
    case underlying(Swift.Error)
}
