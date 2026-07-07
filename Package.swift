// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.19.1.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.1/OpenSwiftUI.xcframework.zip",
    checksum: "8f9b161695ff3a048a122d943c9299472633c30ac0362a3ded7443d31a08a1a2"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.1/OpenSwiftUICore.xcframework.zip",
    checksum: "509b54381a47b7b16af25f2d6af17e2386838843cc74b116fffb776fd2cfd2bb"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.1/OpenAttributeGraphShims.xcframework.zip",
    checksum: "378b87bd7fe22b48ce82f627edf9595196618afecb087ffbdec23dc5d9cd3088"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.1/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "3634fa4543ce9c00539b8cd2aeca16426ac65206240ef8d352b04468a15f463b"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.1/OpenObservation.xcframework.zip",
    checksum: "0e05982fec3d2a08dbb3e84ee0defcd41d0834980f5d73eb3495834d42b07d4a"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.1/OpenQuartzCoreShims.xcframework.zip",
    checksum: "4ace3030b6b8565fd7453a716219263f676762b04e73d21c7a4ea4cde2b58874"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.19.1/OpenRenderBoxShims.xcframework.zip",
    checksum: "c85b0c730a0fe2fad2c66df6cb7e6aa9472ca9e7337d4f795936cc674865dabb"
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
