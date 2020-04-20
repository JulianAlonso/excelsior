/// API Example by Victor Pimentel
/// https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb

import Foundation

public typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

/// Implementation of a generic-based Marvel API client
public class MarvelAPIClient {
    private let baseEndpointUrl = URL(string: "https://gateway.marvel.com:443/v1/public/")!
    private let session = URLSession(configuration: .default)
    
    private let publicKey: String
    private let privateKey: String
    
    public init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    /// Sends a request to Marvel servers, calling the completion method when finished
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) {
        let endpoint = request.endpoint(base: baseEndpointUrl, publicKey: publicKey, privateKey: privateKey)
        
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    // Decode the top level response, and look up the decoded response to see
                    // if it's a success or a failure
                    let marvelResponse = try JSONDecoder().decode(MarvelResponse<T.Response>.self, from: data)
                    
                    if let dataContainer = marvelResponse.data {
                        completion(.success(dataContainer))
                    } else if let message = marvelResponse.message {
                        var code = 0
                        if let httpResponse = response as? HTTPURLResponse {
                            code = httpResponse.statusCode
                        }
                        completion(.failure(MarvelError.server(code: code,
                                                               message: message)))
                    } else {
                        completion(.failure(MarvelError.decoding))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
