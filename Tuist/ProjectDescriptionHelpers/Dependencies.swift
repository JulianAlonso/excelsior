import ProjectDescription

public extension TargetDependency {
    // App
    static let appCore: TargetDependency = .project(target: "AppCore", path: .relativeToRoot("Modules/AppCore"))
    // Features
    static let characterDetailKit: TargetDependency = .project(target: "CharacterDetailKit", path: .relativeToRoot("Modules/CharacterDetailKit"))
    static let characterListKit: TargetDependency = .project(target: "CharacterListKit", path: .relativeToRoot("Modules/CharacterListKit"))
    // Core Dependencies
    static let dataProvidersKit: TargetDependency = .project(target: "DataProvidersKit", path: .relativeToRoot("Modules/DataProvidersKit"))
    static let displayKit: TargetDependency = .project(target: "DisplayKit", path: .relativeToRoot("Modules/DisplayKit"))
    static let marvelClient: TargetDependency = .project(target: "MarvelClient", path: .relativeToRoot("Modules/MarvelClient"))
    static let navigatorKit: TargetDependency = .project(target: "NavigatorKit", path: .relativeToRoot("Modules/NavigatorKit"))
    static let support: TargetDependency = .project(target: "Support", path: .relativeToRoot("Modules/Support"))
    
    //Packages
    static let kingfisher: TargetDependency = .package(product: "Kingfisher")
}

public extension Package {
    static let kingfisher: Package = .package(url: "https://github.com/onevcat/Kingfisher", from: "5.1.0")
}
