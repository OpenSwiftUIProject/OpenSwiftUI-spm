// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.18.2 with Xcode 16.4.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.2/OpenSwiftUI.xcframework.zip",
    checksum: "8bdd075beb5dd37263a46b66e396bb6588c00746d4504c9dc0b2a40f322c1e08"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.2/OpenSwiftUICore.xcframework.zip",
    checksum: "65704b25956297f97add370fa80c320103c1bf8bc4bb15c5ca59e878a9a75ac6"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.2/OpenAttributeGraphShims.xcframework.zip",
    checksum: "1dc843655657bf854fbe4db294dd232b3755235c144b4d2d247037b822fa8222"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.2/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "872cf2ff50e3a44477c608ad11a5c3dfd116763c440422e994427be0e2e00a33"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.2/OpenObservation.xcframework.zip",
    checksum: "f94a16292c04a38bc272b9d65885a522c466a99a6351c88403f405c5dc30eeaf"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.2/OpenQuartzCoreShims.xcframework.zip",
    checksum: "1a392f213c196b2dbbdf72c904a4590d9ffd584617a96d1be120e1115f6c64e2"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.2/OpenRenderBoxShims.xcframework.zip",
    checksum: "2aedd1ea6ad032e297480290af252efb065a170cd4bd4cfc163affa05d5eff84"
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
