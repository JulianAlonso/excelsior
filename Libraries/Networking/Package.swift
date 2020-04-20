// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "Networking", targets: ["Networking"]),
    ],
    targets: [
        .target(name: "Networking", dependencies: [], path: "Sources"),
        .testTarget(name: "NetworkingTests", dependencies: ["Networking"], path: "Tests"),
    ]
)
