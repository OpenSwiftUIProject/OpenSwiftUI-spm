// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.20.1.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.1/OpenSwiftUI.xcframework.zip",
    checksum: "8c5fc90e296ddb18acaf289ca9434885367d97c5374564b63bdcfe1a9ec628b3"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.1/OpenSwiftUICore.xcframework.zip",
    checksum: "011b783bcc1bc67df94a15030b857d38a731d57de55caef0e5de4468c920215e"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.1/OpenAttributeGraphShims.xcframework.zip",
    checksum: "b1abb79acc51ac02c1338fd6c37c4ec47d342e2e2406f2a82ccea54d457649af"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.1/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "cb564684cbcd1e580845f1c54f06cfb044334afedbf2e089a6aedb6ed30aa887"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.1/OpenObservation.xcframework.zip",
    checksum: "ecb2a458ab1249a2d139eb4d8f3ea069edc0b6975fd1896f748f713a675b60ff"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.1/OpenQuartzCoreShims.xcframework.zip",
    checksum: "1df6fcc8bfc3ae1e8c9ae5aad2e781484afb520676f7333d29144f972c35931b"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.1/OpenRenderBoxShims.xcframework.zip",
    checksum: "28f5a4f074a18cda42124c385c4504f512524563ece58e2289f3d9c176585f66"
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
            ]
        ),
    ],
    targets: [
        openSwiftUI,
        openSwiftUICore,
        openAttributeGraphShims,
        openCoreGraphicsShims,
        openObservation,
        openQuartzCoreShims,
        openRenderBoxShims,

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
            ],
            path: "Tests"
        ),
    ]
)
