// swift-tools-version: 6.3

import Foundation
import CompilerPluginSupport
import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.24.1.
let openSwiftUIVersion = "0.24.1"
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
    checksum: "5a9cda4d1cc6eacc96671f5e3a88831baf1194289304dc2c90a2ad508766f515"
)
let openSwiftUICore = openSwiftUIBinaryTarget(
    name: "OpenSwiftUICore",
    checksum: "8d3979cc82d1d4949b4c8463103f3c346772d31d0b704ae105bb4e56e4e10b04"
)
let openAttributeGraphShims = openSwiftUIBinaryTarget(
    name: "OpenAttributeGraphShims",
    checksum: "4ebfca4b38930cb44ab6828dcb6c6f603434c35a63a806fcaa7d6b19e0db67d1"
)
let openCoreGraphicsShims = openSwiftUIBinaryTarget(
    name: "OpenCoreGraphicsShims",
    checksum: "4d91eb190fe908804e781f4c9c7212236d986eafd0cde0846a2c368ce1c091ba"
)
let openObservation = openSwiftUIBinaryTarget(
    name: "OpenObservation",
    checksum: "1a6c50d9a2db694e1e30242730a74e8281a916a9de3dc48844c67de2727dd67d"
)
let openQuartzCoreShims = openSwiftUIBinaryTarget(
    name: "OpenQuartzCoreShims",
    checksum: "13797f6447d75e58cae54cb37ae48944c3d4ae909c2fb6c179cf4932d9a54648"
)
let openRenderBoxShims = openSwiftUIBinaryTarget(
    name: "OpenRenderBoxShims",
    checksum: "8f3e1020e6b5f3d8a679b28b1646cdca671371051e9e431511ad90caa19ea348"
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
