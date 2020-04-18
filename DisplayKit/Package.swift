// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "DisplayKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "DisplayKit", targets: ["DisplayKit"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "DisplayKit", dependencies: [], path: "Sources"),
        .testTarget(name: "DisplayKitTests", dependencies: ["DisplayKit"], path: "Tests")
    ]
)
