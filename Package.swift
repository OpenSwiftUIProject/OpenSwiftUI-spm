// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.18.3 with Xcode 16.4.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.3/OpenSwiftUI.xcframework.zip",
    checksum: "cf22369d0fd7bd41e9351db5dcfc9ce44215a6f26e40ba5bbcf59ce35a8833c8"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.3/OpenSwiftUICore.xcframework.zip",
    checksum: "9b6fd3fd1f6890d181a41bf46cb22ee86549047de5a6a57e7e5d676c8ac4afa3"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.3/OpenAttributeGraphShims.xcframework.zip",
    checksum: "f9bd551d4950451d8e13c154358cdfff2c919ca7a171bd2e66961fbdf18286ef"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.3/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "a84ef78781a721f720255ef481a0d3e8a3f46ae2a7adfe77329ae8dd7c5db4bc"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.3/OpenObservation.xcframework.zip",
    checksum: "217fec37037a50e76c8017537d598c0770e3fa590b331bc684d51e96c9a26a33"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.3/OpenQuartzCoreShims.xcframework.zip",
    checksum: "8e8597d69ce432d793bc9d7287878b86b04005353ba507ff0035e466c47a1120"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.3/OpenRenderBoxShims.xcframework.zip",
    checksum: "c00f840cbb0d72b51b1bb94e0efd9323cbf9a284bea814e249cc0992ce5d4e59"
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
