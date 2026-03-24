// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.17.0 with Xcode 16.4.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.0/OpenSwiftUI.xcframework.zip",
    checksum: "7809b0b3426e081c82b4142cc825a910be2622ebef28019e0840d3b38ee87f56"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.0/OpenSwiftUICore.xcframework.zip",
    checksum: "03907a9e829f1979bc18f96d2e9296aa8fe6e391d12af21ff88b709756f235c5"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.0/OpenAttributeGraphShims.xcframework.zip",
    checksum: "36b69edfd797ab6529b0accec844f23baeab70c3eb1cd07ca0e1b9dcaed2a837"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.0/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "0cf8249e5b794ff3976f631c5abe43e9493bf65c0984ca7f1d0b6a636c867e9b"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.0/OpenObservation.xcframework.zip",
    checksum: "52d3bb665e9f78ea541a95f41bd8c09867d48b186fc3d4bf9cca027991258555"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.0/OpenQuartzCoreShims.xcframework.zip",
    checksum: "a3a76c440d47ec1c4db62566e8a44c2c15e0862cdda8f6317187c43d693c5317"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.0/OpenRenderBoxShims.xcframework.zip",
    checksum: "bc5bda5c419780a7325b5e92b3fc5937ae6e618547832578d2eae23aec16553d"
)

// MARK: - Package

let package = Package(
    name: "OpenSwiftUI",
    platforms: [.iOS("18.0"), .macOS("15.0")],
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
                "_OpenSwiftUIStub",
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

        // Without at least one regular (non-binary) target, this package doesn't show up
        // in Xcode under "Frameworks, Libraries, and Embedded Content". That prevents
        // the framework from being embedded in the app product, causing the app to crash
        // when ran on a physical device. As a workaround, we can include a stub target
        // with at least one source file.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(name: "_OpenSwiftUIStub"),

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
