import ProjectDescription

public extension TargetDependency {
    // App
    static let appCore: TargetDependency = .project(target: "AppCore", path: .relativeToRoot("Modules/AppCore"))
    // Features
    static let characterDetailKit: TargetDependency = .project(target: "CharacterDetailKit", path: .relativeToRoot("Modules/CharacterDetailKit"))
    static let characterListKit: TargetDependency = .project(target: "CharacterListKit", path: .relativeToRoot("Modules/CharacterListKit"))
    // Core Dependencies
    static let core: TargetDependency = .project(target: "Core", path: .relativeToRoot("Modules/Core"))
    static let displayKit: TargetDependency = .project(target: "DisplayKit", path: .relativeToRoot("Modules/DisplayKit"))
    static let marvelClient: TargetDependency = .project(target: "MarvelClient", path: .relativeToRoot("Modules/MarvelClient"))
    static let navigatorKit: TargetDependency = .project(target: "NavigatorKit", path: .relativeToRoot("Modules/NavigatorKit"))
    static let support: TargetDependency = .project(target: "Support", path: .relativeToRoot("Modules/Support"))
    
    //Packages
    static let kingfisher: TargetDependency = .package(product: "Kingfisher")
    static let promises: TargetDependency = .package(product: "Promises")
    static let networking: TargetDependency = .package(product: "Networking")
    static let injection: TargetDependency = .package(product: "Injection")
    static let storage: TargetDependency = .package(product: "Storage")
    static let networkingPromises: TargetDependency = .package(product: "NetworkingPromises")
}

public extension Package {
    static let kingfisher: Package = .package(url: "https://github.com/onevcat/Kingfisher", from: "5.1.0")
    static let promises: Package = .package(path: .relativeToRoot("Libraries/Promises"))
    static let networking: Package = .package(path: .relativeToRoot("Libraries/Networking"))
    static let injection: Package = .package(url: "https://github.com/JulianAlonso/Injection", from: "0.0.0")
    static let storage: Package = .package(path: .relativeToRoot("Libraries/Storage"))
}
