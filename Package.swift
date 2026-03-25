// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.17.1 with Xcode 16.4.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.1/OpenSwiftUI.xcframework.zip",
    checksum: "6b3268cb2a0a80d55697bf14be679eae262598ef944ec0ca9cd97fd1f7fe1281"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.1/OpenSwiftUICore.xcframework.zip",
    checksum: "139c786891762250dc77c1200a6161942a9097e4f82781b0967da10126df6a5d"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.1/OpenAttributeGraphShims.xcframework.zip",
    checksum: "52e5383ee946275c630f3229039fe4a5b880d82eb6f78e5ec39c2a7b6554af88"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.1/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "ab081626e02dfffd2ae6022126779201d3204ce2a64eab19349fd1e38ea67162"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.1/OpenObservation.xcframework.zip",
    checksum: "45fd050e1a39aabb6a8353caffbc7426734af636b886ed58712214706f9d416f"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.1/OpenQuartzCoreShims.xcframework.zip",
    checksum: "bfbedb989cfea3167cd925f6430d93606ae504df688770036e0f282a37d4ede4"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.1/OpenRenderBoxShims.xcframework.zip",
    checksum: "8e3ba3de94ed3c010a1af1caa7c0ad951b2be9f99990a112a435ef7013f1506f"
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
