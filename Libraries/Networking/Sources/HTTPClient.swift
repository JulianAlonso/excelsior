//
//  File.swift
//  
//
//  Created by Juli Alonso on 20/04/2020.
//

import Foundation

public typealias ResultCallback<Value> = (Result<Value, Swift.Error>) -> Void

public class MarvelAPIClient {
    private let baseEndpointUrl = URL(string: "https://gateway.marvel.com:443/v1/public/")!
    private let session = URLSession(configuration: .default)
    
    private let publicKey: String
    private let privateKey: String
    
    public init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<Page<T.Response>>) {
        let endpoint = request.endpoint(base: baseEndpointUrl, publicKey: publicKey, privateKey: privateKey)
        
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            do {
                switch (data, response, error) {
                case let (.some(data), .some(response), _) where response.hasOkStatus:
                    let body = try JSONDecoder().decode(Response<T.Response>.self, from: data).body
                    completion(.success(body))
                    return
                case let (.some(data), .some(response), _) where !response.hasOkStatus:
                    let code = response.httpCode!
                    let error = try JSONDecoder().decode(MarvelError.self, from: data)
                    completion(.failure(Error.known(code: code, body: error)))
                    return
                case let (_, _, .some(error)):
                    completion(.failure(Error<MarvelError>.underlying(error)))
                    return
                default: fatalError("Impossible")
                }
            } catch {
                completion(.failure(Error<MarvelError>.underlying(error)))
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
