// swift-tools-version: 6.3

import Foundation
import CompilerPluginSupport
import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.23.1.
let openSwiftUIVersion = "0.23.1"
let openSwiftUIReleaseBaseURL = "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/\(openSwiftUIVersion)"
let packageDirectory = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
let localXCFrameworksDirectory = Context.environment["OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH"].flatMap { path in
    path.isEmpty ? nil : URL(fileURLWithPath: path, relativeTo: packageDirectory).standardizedFileURL
}

func relativePath(from directory: URL, to file: URL) -> String {
    let directoryComponents = directory.standardizedFileURL.pathComponents
    let fileComponents = file.standardizedFileURL.pathComponents
    var commonComponentCount = 0
    while commonComponentCount < directoryComponents.count &&
          commonComponentCount < fileComponents.count &&
          directoryComponents[commonComponentCount] == fileComponents[commonComponentCount] {
        commonComponentCount += 1
    }
    let parentComponents = Array(repeating: "..", count: directoryComponents.count - commonComponentCount)
    return (parentComponents + fileComponents.dropFirst(commonComponentCount)).joined(separator: "/")
}

func openSwiftUIBinaryTarget(name: String, checksum: String) -> Target {
    if let localXCFrameworksDirectory {
        let localXCFramework = localXCFrameworksDirectory.appendingPathComponent("\(name).xcframework")
        if FileManager.default.fileExists(atPath: localXCFramework.path) {
            return .binaryTarget(
                name: name,
                path: relativePath(from: packageDirectory, to: localXCFramework)
            )
        }
    }
    return .binaryTarget(
        name: name,
        url: "\(openSwiftUIReleaseBaseURL)/\(name).xcframework.zip",
        checksum: checksum
    )
}

let openSwiftUI = openSwiftUIBinaryTarget(
    name: "OpenSwiftUI",
    checksum: "2a067e4841b19cde3bc157ef12ff3a463b0052ff6dcd223d68d9f63e6c63e75d"
)
let openSwiftUICore = openSwiftUIBinaryTarget(
    name: "OpenSwiftUICore",
    checksum: "b13cbde7e3d7ba5a77ffa25c98df778b4f5f112f8b32658dcd15720defcb8c6c"
)
let openAttributeGraphShims = openSwiftUIBinaryTarget(
    name: "OpenAttributeGraphShims",
    checksum: "1ad8331762272ba60a1a7610ee25f94371b70d20ba70c022f8e2145d2c94d3a1"
)
let openCoreGraphicsShims = openSwiftUIBinaryTarget(
    name: "OpenCoreGraphicsShims",
    checksum: "ece0280b2e53cfa67cd9fc7740285a644f70485358a4206e75eff16c656ac640"
)
let openObservation = openSwiftUIBinaryTarget(
    name: "OpenObservation",
    checksum: "73d262c9004c63f0bbf70fb4ba854aa5e624571ddeb91a704ff43bff209c5456"
)
let openQuartzCoreShims = openSwiftUIBinaryTarget(
    name: "OpenQuartzCoreShims",
    checksum: "6ca12e87ecbb35216214ef7e53f444cda9d0a4da56ce7a8a534ef7ac617824c8"
)
let openRenderBoxShims = openSwiftUIBinaryTarget(
    name: "OpenRenderBoxShims",
    checksum: "0bcc5e8bf00aa13b3718d1189d9aeea0a9cfb52bf20f88fbca2fad60a96eeabe"
)

// MARK: - Host Macro Targets

// Mirrored from the matching OpenSwiftUI release by its release workflow.
let openSwiftUIMacros = Target.macro(
    name: "OpenSwiftUIMacros",
    dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
    ],
    swiftSettings: [
        .enableUpcomingFeature("InternalImportsByDefault"),
    ]
)

let openObservationMacros = Target.macro(
    name: "OpenObservationMacros",
    dependencies: [
        .product(name: "SwiftDiagnostics", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
    ],
    swiftSettings: [
        .swiftLanguageMode(.v5),
    ]
)

// MARK: - Package

let package = Package(
    name: "OpenSwiftUI",
    /*
     * If we add this correct information, many SUI package can't add this to their Package.swift to adapt for OSUI
     * as we can't conditional change platforms for trait. So keep leave this for now.
     * And the final MachO target must match the OS version to successfully link the framework.
     */
    // platforms: [.iOS(.v18), .macOS(.v15)],
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "OpenSwiftUI",
            targets: [
                "OpenSwiftUI",
                "OpenSwiftUICore",
                "OpenCoreGraphicsShims",
                "OpenObservation",
                "OpenQuartzCoreShims",
                "OpenRenderBoxShims",
                "OpenSwiftUIMacros",
                "OpenObservationMacros",
            ]
        ),
        .library(name: "OpenSwiftUIPlayground", targets: ["OpenSwiftUIPlayground"]),
        .library(name: "SwiftUIPlayground", targets: ["SwiftUIPlayground"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "603.0.0"),
    ],
    targets: [
        openSwiftUI,
        openSwiftUICore,
        openAttributeGraphShims,
        openCoreGraphicsShims,
        openObservation,
        openQuartzCoreShims,
        openRenderBoxShims,
        openSwiftUIMacros,
        openObservationMacros,
        .target(
            name: "OpenSwiftUIPlayground",
            dependencies: [
                "OpenSwiftUI",
                "OpenSwiftUICore",
                "OpenAttributeGraphShims",
                "OpenCoreGraphicsShims",
                "OpenObservation",
                "OpenQuartzCoreShims",
                "OpenRenderBoxShims",
                "OpenSwiftUIMacros",
                "OpenObservationMacros",
            ],
        ),
        .target(name: "SwiftUIPlayground"),
        .testTarget(
            name: "OpenSwiftUITests",
            dependencies: [
                "OpenSwiftUI",
                "OpenSwiftUICore",
                "OpenAttributeGraphShims",
                "OpenCoreGraphicsShims",
                "OpenObservation",
                "OpenQuartzCoreShims",
                "OpenRenderBoxShims",
                "OpenSwiftUIMacros",
                "OpenObservationMacros",
            ],
            path: "Tests"
        ),
    ]
)
