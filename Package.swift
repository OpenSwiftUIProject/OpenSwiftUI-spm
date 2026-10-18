// swift-tools-version: 6.3

import Foundation
import CompilerPluginSupport
import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.24.0.
let openSwiftUIVersion = "0.24.0"
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
    checksum: "a05a861ff63d3c2381ede63109f1c4b03f6c5e961875523e807c234e07b26ec4"
)
let openSwiftUICore = openSwiftUIBinaryTarget(
    name: "OpenSwiftUICore",
    checksum: "1e552fb61fcd6e9c6ebc798757c722046a2e7737eacd9288f9d192f1e83120ff"
)
let openAttributeGraphShims = openSwiftUIBinaryTarget(
    name: "OpenAttributeGraphShims",
    checksum: "a89465d95d8438c683b32263d9e03c5fb9770cc9df9e3ae86b705198f32f5117"
)
let openCoreGraphicsShims = openSwiftUIBinaryTarget(
    name: "OpenCoreGraphicsShims",
    checksum: "c64da267570e913e86afdf5aa48a902b377a2e278d83c4e83a6b4b3dc286b19b"
)
let openObservation = openSwiftUIBinaryTarget(
    name: "OpenObservation",
    checksum: "60cf68517e2c869038109f9ffbecbbd0dd4369d26473dcbd7935aa7a9bd57610"
)
let openQuartzCoreShims = openSwiftUIBinaryTarget(
    name: "OpenQuartzCoreShims",
    checksum: "a93b04f01784b29fa02375578b9f903fd26cad193c2db65eb38c6c3cd83c591f"
)
let openRenderBoxShims = openSwiftUIBinaryTarget(
    name: "OpenRenderBoxShims",
    checksum: "98e24893fbe560351d73946a070d7e241085f0c5724cffeec7e61e3f1109ac35"
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
