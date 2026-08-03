// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.20.0.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.0/OpenSwiftUI.xcframework.zip",
    checksum: "328f34d78eb1da689f080506266decd35dbfc868883c3753c4110fde9eb04490"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.0/OpenSwiftUICore.xcframework.zip",
    checksum: "f83b264ba73753a4bbd5a3582407b66ae99d27f1ed3a373cdc791dd6f78056af"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.0/OpenAttributeGraphShims.xcframework.zip",
    checksum: "3a8cb856db82dff25ea90813963c6b6bd70423eb1d6b6c42bb64fabd1eca6dd6"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.0/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "87f57a21a40be6b12d18931a6f3522379d87e4c28f4bfeed75a20dd10a46ece0"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.0/OpenObservation.xcframework.zip",
    checksum: "591fed668f1b6602549cc09cc4412880dec169a92465d4a348919f475778ad7e"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.0/OpenQuartzCoreShims.xcframework.zip",
    checksum: "1f3fde6341744a2e591a2f17fe7922eccaba7e810f003ff189fd500b825f2bfb"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.20.0/OpenRenderBoxShims.xcframework.zip",
    checksum: "979739ab659962ec18d632638e1775474fd92701c41776f4ad880837c5a89cf6"
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
