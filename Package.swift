// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.19.2.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.2/OpenSwiftUI.xcframework.zip",
    checksum: "0518dda041edb65daeadf778db0c42f0f2953823382fd01cc84f9fa9d7071a4c"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.2/OpenSwiftUICore.xcframework.zip",
    checksum: "49c3f882edd00adc6bd92cb33cfd141161860e13637ea0d3d20734435ac437ff"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.2/OpenAttributeGraphShims.xcframework.zip",
    checksum: "140f58c6dba5f1ae0b3c182c82b1f7ac3ce3b1b9a509fb26d0140422a465fda2"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.2/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "f96dcf0824f9193bc59beec855a82d2dfbb34530ee50317168cade5a0faed1d1"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.2/OpenObservation.xcframework.zip",
    checksum: "99a7bfdeea1bd9ec29b03d0832a5ac967822e2292d3116b1a460e06a1b95945e"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.2/OpenQuartzCoreShims.xcframework.zip",
    checksum: "151b60184eec71d2055508e1e10891d17ab19166f1df969be932d84a192c95f6"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.2/OpenRenderBoxShims.xcframework.zip",
    checksum: "a6616b1f64a3d9566bf78d7bec2ade4a06a7182e4731182d94212286a2ad1261"
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
