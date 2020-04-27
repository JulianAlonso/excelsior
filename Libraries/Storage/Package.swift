// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Storage",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "Storage", targets: ["Storage"]),
    ],
    targets: [
        .target(name: "Storage", dependencies: [], path: "Sources"),
        .testTarget(name: "StorageTests", dependencies: ["Storage"], path: "Tests"),
    ]
)
