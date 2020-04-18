// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "MarvelClient",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "MarvelClient", targets: ["MarvelClient"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "MarvelClient", dependencies: [], path: "Sources"),
        .testTarget(name: "MarvelClientTests", dependencies: ["MarvelClient"], path: "Tests")
    ]
)
