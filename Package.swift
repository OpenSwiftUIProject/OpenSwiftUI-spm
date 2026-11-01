// swift-tools-version: 6.3

import Foundation
import CompilerPluginSupport
import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.25.0.
let openSwiftUIVersion = "0.25.0"
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
    checksum: "4b6147884a2452b55af2f3403714172310cda8793ef2d9714dd7c670b8661951"
)
let openSwiftUICore = openSwiftUIBinaryTarget(
    name: "OpenSwiftUICore",
    checksum: "bb2a7fcf22f730abe92f4c4199b8fc597428106546e7392a6c7a981afa4e6135"
)
let openAttributeGraphShims = openSwiftUIBinaryTarget(
    name: "OpenAttributeGraphShims",
    checksum: "ec6c275967cf6c428f13c42723d857b00045b15f69fdb137a179e65aa69561cb"
)
let openCoreGraphicsShims = openSwiftUIBinaryTarget(
    name: "OpenCoreGraphicsShims",
    checksum: "e2341ccf75a6f3a51d825f9f85edfd7dc7f8fcff40385b0a1d58ddd21d2d6163"
)
let openObservation = openSwiftUIBinaryTarget(
    name: "OpenObservation",
    checksum: "f3ee3a0673fa1dc4e0388db20d2b6166645979794143b22f297231321ac570fc"
)
let openQuartzCoreShims = openSwiftUIBinaryTarget(
    name: "OpenQuartzCoreShims",
    checksum: "d2e1740814b0fb3f273034e5761f4106e88d4c10527ac0a7deb76c6bfef8f9c0"
)
let openRenderBoxShims = openSwiftUIBinaryTarget(
    name: "OpenRenderBoxShims",
    checksum: "b369c1fe921f17776594502824b82affbd7d23c0d9f086c474c27b7f93a60dcb"
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
    // platforms: [.iOS(.v18), .macOS(.v15), .visionOS(.v2)],
    platforms: [.iOS(.v15), .macOS(.v12), .visionOS(.v1)],
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
