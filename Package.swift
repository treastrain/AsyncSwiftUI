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
            name: "AsyncSwiftUI",
            dependencies: [
                "Control",
            ]),
        .target(
            name: "Core"),
        .target(
            name: "Control",
            dependencies: ["Core"]
        ),
        .testTarget(
            name: "AsyncSwiftUITests",
            dependencies: ["AsyncSwiftUI"]),
    ]
)

package.targets.forEach {
    $0.swiftSettings = [
        .enableUpcomingFeature("ConciseMagicFile"), // SE-0274
        .enableUpcomingFeature("ForwardTrailingClosures"), // SE-0286
        .enableUpcomingFeature("ExistentialAny"), // SE-0335
        .enableUpcomingFeature("StrictConcurrency"), // SE-0337
        .enableUpcomingFeature("BareSlashRegexLiterals"), // SE-0354
        .enableUpcomingFeature("ImportObjcForwardDeclarations"), // SE-0384
        .enableUpcomingFeature("DisableOutwardActorInference"), // SE-0401
        .enableUpcomingFeature("InternalImportsByDefault"), // SE-0409
    ]
}
