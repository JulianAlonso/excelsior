/// API Example by Victor Pimentel
/// https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb

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
    
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) {
        let endpoint = request.endpoint(base: baseEndpointUrl, publicKey: publicKey, privateKey: privateKey)
        
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            
            switch (data, response, error) {
            case let (.some(data), .some(response), _) where response.hasOkStatus: break
            case let (.some(data), .some(response), _) where !response.hasOkStatus: break
            default: break
            }
        }
        
        task.resume()
    }
}

extension URLResponse {
    var okStatuses: [Int] { Array(200...300) }
    var hasOkStatus: Bool {
        guard let response = self as? HTTPURLResponse else { return false }
        return okStatuses.contains(response.statusCode)
    }
}
