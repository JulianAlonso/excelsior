// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "CharacterDetailKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "CharacterDetailKit", targets: ["CharacterDetailKit"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "CharacterDetailKit", dependencies: [], path: "Sources"),
        .testTarget(name: "CharacterDetailKitTests", dependencies: ["CharacterDetailKit"], path: "Tests")
    ]
)
