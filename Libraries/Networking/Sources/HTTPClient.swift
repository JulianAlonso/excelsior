//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

public typealias Callback<T, E: Swift.Error> = (Result<T, E>) -> Void

public class HTTPClient {
    private let host = URL(string: "https://gateway.marvel.com:443/v1/public/")!
    private let session = URLSession(configuration: .default)
    
    private let publicKey: String
    private let privateKey: String
    
    public init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    public func perform<T: Decodable, E: Decodable>(_ endpoint: Endpoint, completion: @escaping Callback<T, Error<E>>) {
        let url = endpoint.encode(to: host)
        
        let task = session.dataTask(with: url) { data, response, error in
            do {
                switch (data, response, error) {
                case let (.some(data), .some(response), _) where response.hasOkStatus:
                    let body = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(body))
                    return
                case let (.some(data), .some(response), _) where !response.hasOkStatus:
                    let code = response.httpCode!
                    let error = try JSONDecoder().decode(E.self, from: data)
                    completion(.failure(.known(code: code, body: error)))
                    return
                case let (_, _, .some(error)):
                    completion(.failure(.underlying(error)))
                    return
                default: fatalError("Impossible")
                }
            } catch {
                completion(.failure(.underlying(error)))
            }
        }
        task.resume()
    }
}

extension URLResponse {
    var okStatuses: [Int] { Array(200...300) }
    var httpCode: Int? { (self as? HTTPURLResponse)?.statusCode }
    var hasOkStatus: Bool { httpCode.map { okStatuses.contains($0) } ?? false }
}
