// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AsyncSwiftUI",
    platforms: [.iOS(.v15), .macOS(.v12), .macCatalyst(.v15), .tvOS(.v15), .watchOS(.v8), .visionOS(.v1)],
    products: [
        .library(
            name: "AsyncSwiftUI",
            targets: ["AsyncSwiftUI"]),
    ],
    targets: [
        .target(
            name: "AsyncSwiftUI"),
        .testTarget(
            name: "AsyncSwiftUITests",
            dependencies: ["AsyncSwiftUI"]),
    ]
)
