// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "CharacterListKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "CharacterListKit", targets: ["CharacterListKit"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "CharacterListKit", dependencies: [], path: "Sources"),
        .testTarget(name: "CharacterListKitTests", dependencies: ["CharacterListKit"], path: "Tests")
    ]
)
