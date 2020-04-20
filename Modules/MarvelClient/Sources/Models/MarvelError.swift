/// API Example by Victor Pimentel
/// https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb

/// Dumb error to model simple errors
/// In a real implementation this should be more exhaustive
public enum MarvelError: Swift.Error {
    case encoding
    case decoding
    case server(code: Int, message: String)
}

extension MarvelError: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code = try container.decode(Int.self, forKey: .code)
        let status = try container.decode(String.self, forKey: .status)
        self = .server(code: code, message: status)
    }
    
}
