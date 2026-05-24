// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.18.1 with Xcode 16.4.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.1/OpenSwiftUI.xcframework.zip",
    checksum: "325690909fa475e97d2afde2af251bb7dab517517f7b9d1de5b45b3bc1224ec4"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.1/OpenSwiftUICore.xcframework.zip",
    checksum: "1714bc7b2b4c36181c648ae96a46015f4819aa572eff4203034ad2295b3856ad"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.1/OpenAttributeGraphShims.xcframework.zip",
    checksum: "7fd41f6416b9a6284f5cc6bee48ec5c699bae8e3dd6daccb3d3715239106290d"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.1/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "b80bdc7c2295f653a23a0ee335952e87c10a60414727be58a4317200cc968542"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.1/OpenObservation.xcframework.zip",
    checksum: "fcec7597a597ec9f743804ab2239d302bca28a7f9c580b41b3450d6d2345f19b"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.1/OpenQuartzCoreShims.xcframework.zip",
    checksum: "58d9014cc2002aa33ed31d4eaf48e8d0f3a353782fbe499cfc4cf491f13effea"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.1/OpenRenderBoxShims.xcframework.zip",
    checksum: "6cff5206901e103f76f6f9a52dbf3b64312d1a3f8b90d4a3f1282243641d6ced"
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
