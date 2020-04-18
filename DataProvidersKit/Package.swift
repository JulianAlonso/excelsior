// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "DataProvidersKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "DataProvidersKit", targets: ["DataProvidersKit"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "DataProvidersKit", dependencies: [], path: "Sources"),
        .testTarget(name: "DataProvidersKitTests", dependencies: ["DataProvidersKit"], path: "Tests")
    ]
)
