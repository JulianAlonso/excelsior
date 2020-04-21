/// API Example by Victor Pimentel
/// https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb

import Foundation
import Core

public struct Character: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: Image?
}

extension Character {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    var coreCharacter: Core.Character {
        Core.Character(id: id,
                       name: name ?? "Unkown name",
                       bio: description ?? "No description",
                       thumbnailURL: thumbnail?.url,
                       modified: modified.flatMap { Character.dateFormatter.date(from: $0) } ?? Date())
    }
}
