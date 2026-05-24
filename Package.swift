// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.18.0 with Xcode 16.4.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.0/OpenSwiftUI.xcframework.zip",
    checksum: "33f360a43ee0565d441dbcbd1f071d43f6063433794be39d7b04cd3d05df1f6c"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.0/OpenSwiftUICore.xcframework.zip",
    checksum: "2fd89433ab121af3ea02dfbb29293f33e8f22039a3bbbba6be37efbfa80e34e8"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.0/OpenAttributeGraphShims.xcframework.zip",
    checksum: "2ece6c1503b25a8c18582abb954d985e470fc4f80ca910f82a745e5952b87815"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.0/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "9a475aa29c55dc7b2d5b51f7416d74c21f1704f87dddffa39cfd4c1ae80626d7"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.0/OpenObservation.xcframework.zip",
    checksum: "d44ed1ce551ebb9170f768b061145781ec3266ebff6f1fb796e672588e2ffb0c"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.0/OpenQuartzCoreShims.xcframework.zip",
    checksum: "d34be7dcd151b8cb7320df21f596c6c9f73e657ac60e1d11c461dbb59beb3074"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.18.0/OpenRenderBoxShims.xcframework.zip",
    checksum: "225b3be54c537b6c78030695f6f21c675411f6363c688274f8b1aa587bc3c0fe"
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
