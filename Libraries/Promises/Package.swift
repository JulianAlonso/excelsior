// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Promises",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "Promises", targets: ["Promises"]),
    ],
    targets: [
        .target(name: "Promises", dependencies: [], path: "Sources"),
        .testTarget(name: "PromisesTests", dependencies: ["Promises"], path: "Tests"),
    ]
)
