// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.17.2 with Xcode 16.4.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.2/OpenSwiftUI.xcframework.zip",
    checksum: "e78b3dc2d2e43b5748f62e186677ea7f16c7c5a089b416449d6d6b27f497427e"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.2/OpenSwiftUICore.xcframework.zip",
    checksum: "9110190201276367723acecc42dd60e38129d768fa3cc549708fc5b6f9bf8816"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.2/OpenAttributeGraphShims.xcframework.zip",
    checksum: "d8321a99334a9aacf3c96011798eb60ed0c7f252563554e07de7519b076bfe65"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.2/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "9b047ed0f4470c9dc66222c08bdd66b5100279bb84e10df57b7b1a2de46935bf"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.2/OpenObservation.xcframework.zip",
    checksum: "6476834ab378f2e5308c9626404e23cda00ffd708bab365f1c00194649478732"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.2/OpenQuartzCoreShims.xcframework.zip",
    checksum: "9e251943aead9fcd29688b7a8d38fdbb786ab08a6820906e49e055fc0158514f"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.2/OpenRenderBoxShims.xcframework.zip",
    checksum: "2054c0af0e70bccc98e626a3df262febea33196bca7e0ef62c876c4bd1c59de4"
)

// MARK: - Package

let package = Package(
    name: "OpenSwiftUI",
    platforms: [.iOS(.v18), .macOS(.v15)],
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
