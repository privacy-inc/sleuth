// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Sleuth",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "Sleuth",
            targets: ["Sleuth"]),
    ],
    targets: [
        .target(
            name: "Sleuth",
            path: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: ["Sleuth"],
            path: "Tests"),
    ]
)
