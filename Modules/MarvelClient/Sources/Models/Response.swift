/// API Example by Victor Pimentel
/// https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb

import Foundation

public struct Response<Body: Decodable>: Decodable {
    public let body: DataContainer<Body>?
}
