// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "ExampleDependencies",
    dependencies: [
        .package(path: "../../"),
    ]
)
