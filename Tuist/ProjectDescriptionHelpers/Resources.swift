import ProjectDescription

public enum ResourceType: String {
    case xibs        = "Sources/**/*.xib"
    case storyboards = "Resources/**/*.storyboard"
    case assets      = "Resources/**"
}

public extension Array where Element == FileElement {
    static func resources(with resources: [ResourceType]) -> [FileElement] {
        resources.map { FileElement(stringLiteral: $0.rawValue) }
    }
}
