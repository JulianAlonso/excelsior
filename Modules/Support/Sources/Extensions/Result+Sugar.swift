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
    
    func tryMap<NewSuccess, NewFailure>(transformSuccess: (Success) throws -> NewSuccess,
                                        transformFailure: (Failure) -> NewFailure) -> Result<NewSuccess, NewFailure> {
        do {
            switch self {
            case .success(let success): return .success(try transformSuccess(success))
            case .failure(let error): return .failure(transformFailure(error))
            }
        } catch {
            return .failure(error as! NewFailure)
        }
    }
}

