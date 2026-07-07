// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.19.0.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.0/OpenSwiftUI.xcframework.zip",
    checksum: "5c76a95bdaee07dce8dd625aa3737833f7259ba8dc9b8405929aaa70aea59912"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.0/OpenSwiftUICore.xcframework.zip",
    checksum: "e49b2479aaf6f583ddfba2f3970815f09143d7c08dba745627bd263cb1febdf6"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.0/OpenAttributeGraphShims.xcframework.zip",
    checksum: "090f7833f123713e68d5cba87fdc84286c4ff803698c898ea334c58306a6f7ad"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.0/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "46f88f368f7d6d8cfa7316a32711c0fbfbe75808a0d03ec53b2ce63f6b531293"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.0/OpenObservation.xcframework.zip",
    checksum: "02e7462412906c233ab50739a812a0f8a8dcbea012f740e00ca835e499d8c160"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.0/OpenQuartzCoreShims.xcframework.zip",
    checksum: "2a557301f9adf7c2077468a27cafe29e197585cbea49f008749a26e7722b59bd"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.0/OpenRenderBoxShims.xcframework.zip",
    checksum: "63b56481aebb580ed3403b590638ddb4df93ede4bbed43ba59b02d7661429eed"
)

// MARK: - Package

let package = Package(
    name: "OpenSwiftUI",
    products: [
        .library(
            name: "OpenSwiftUI",
            targets: [
                "OpenSwiftUI",
                "OpenSwiftUICore",
                "OpenAttributeGraphShims",
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
