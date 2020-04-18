// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Support",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "Support", targets: ["Support"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Support", dependencies: [], path: "Sources"),
        .testTarget(name: "SupportTests", dependencies: ["Support"], path: "Tests")
    ]
)
