//
//  Result+Sugar.swift
//  Support
//
//  Created by Juli Alonso on 21/04/2020.
//

import Foundation

public extension Result {
    func mapTerror<NewFailure>(_ transform: (Failure) -> NewFailure) -> Result<Success, NewFailure> {
        switch self {
        case .success(let value): return .success(value)
        case .failure(let error): return .failure(transform(error))
        }
    }
}

