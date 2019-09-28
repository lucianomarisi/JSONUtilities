// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "JSONUtilities",
    products: [
        .library(
            name: "JSONUtilities",
            targets: ["JSONUtilities"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "JSONUtilities",
            dependencies: []),
        .testTarget(
            name: "JSONUtilitiesTests",
            dependencies: ["JSONUtilities"]),
    ]
)
