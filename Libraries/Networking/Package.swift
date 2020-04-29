// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "NetworkingPromises", targets: ["NetworkingPromises"])
    ],
    dependencies: [
        .package(path: "../Promises")
    ],
    targets: [
        .target(name: "Networking", dependencies: []),
        .target(name: "NetworkingPromises", dependencies: ["Networking", "Promises"]),
        .testTarget(name: "NetworkingTests", dependencies: ["Networking"]),
        .testTarget(name: "NetworkingPromisesTests", dependencies: ["NetworkingPromises"])
    ]
)
