// swift-tools-version: 6.3

import Foundation
import CompilerPluginSupport
import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.20.1.
let openSwiftUIVersion = "0.20.1"
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
    checksum: "8c5fc90e296ddb18acaf289ca9434885367d97c5374564b63bdcfe1a9ec628b3"
)
let openSwiftUICore = openSwiftUIBinaryTarget(
    name: "OpenSwiftUICore",
    checksum: "011b783bcc1bc67df94a15030b857d38a731d57de55caef0e5de4468c920215e"
)
let openAttributeGraphShims = openSwiftUIBinaryTarget(
    name: "OpenAttributeGraphShims",
    checksum: "b1abb79acc51ac02c1338fd6c37c4ec47d342e2e2406f2a82ccea54d457649af"
)
let openCoreGraphicsShims = openSwiftUIBinaryTarget(
    name: "OpenCoreGraphicsShims",
    checksum: "cb564684cbcd1e580845f1c54f06cfb044334afedbf2e089a6aedb6ed30aa887"
)
let openObservation = openSwiftUIBinaryTarget(
    name: "OpenObservation",
    checksum: "ecb2a458ab1249a2d139eb4d8f3ea069edc0b6975fd1896f748f713a675b60ff"
)
let openQuartzCoreShims = openSwiftUIBinaryTarget(
    name: "OpenQuartzCoreShims",
    checksum: "1df6fcc8bfc3ae1e8c9ae5aad2e781484afb520676f7333d29144f972c35931b"
)
let openRenderBoxShims = openSwiftUIBinaryTarget(
    name: "OpenRenderBoxShims",
    checksum: "28f5a4f074a18cda42124c385c4504f512524563ece58e2289f3d9c176585f66"
)

// MARK: - Host Macro Target

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
            ],
            path: "Tests"
        ),
    ]
)
