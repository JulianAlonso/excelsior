// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "AppCore",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "AppCore", targets: ["AppCore"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "AppCore", dependencies: [], path: "Sources"),
        .testTarget(name: "AppCoreTests", dependencies: ["AppCore"], path: "Tests")
    ]
)
