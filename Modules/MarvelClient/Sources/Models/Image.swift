/// API Example by Victor Pimentel
/// https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb

import Foundation

/// Common object for images coming from the Marvel API
/// Shows how to fully conform to Decodable
public struct Image: Decodable {
    /// Server sends the remote URL splits in two: the path and the extension
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    /// The remote URL for this image
    public let url: URL
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        
        let url = URL(string: "\(path).\(fileExtension)")!
        
        self.url = url
    }
}

