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
    dependencies: [
        .package(name: "Archivable", url: "https://github.com/archivable/package.git", .branch("main"))
    ],
    targets: [
        .target(
            name: "Sleuth",
            dependencies: ["Archivable"],
            path: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: ["Sleuth"],
            path: "Tests"),
    ]
)
