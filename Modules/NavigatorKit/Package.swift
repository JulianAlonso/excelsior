// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "NavigatorKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "NavigatorKit", targets: ["NavigatorKit"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "NavigatorKit", dependencies: [], path: "Sources"),
        .testTarget(name: "NavigatorKitTests", dependencies: ["NavigatorKit"], path: "Tests")
    ]
)
