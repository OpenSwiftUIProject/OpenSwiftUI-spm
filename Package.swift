// swift-tools-version: 6.0

import PackageDescription

// MARK: - Binary Targets

/// XCFrameworks compiled from OpenSwiftUI 0.17.3 with Xcode 16.4.
let openSwiftUI = Target.binaryTarget(
    name: "OpenSwiftUI",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.3/OpenSwiftUI.xcframework.zip",
    checksum: "1f120b75f9b87878f846d56ec187c760227bb3b32dadadada0866ce19fb206da"
)

let openSwiftUICore = Target.binaryTarget(
    name: "OpenSwiftUICore",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.3/OpenSwiftUICore.xcframework.zip",
    checksum: "b1b4486778e5e61ba5baac364943e44ae4f179ae54a1abf651f0bedd9cce7e08"
)

let openAttributeGraphShims = Target.binaryTarget(
    name: "OpenAttributeGraphShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.3/OpenAttributeGraphShims.xcframework.zip",
    checksum: "eea6598dc0d0ac2a7928295ecf92a48f52fecfa31a2e82c57fb943ccd3eb9ec6"
)

let openCoreGraphicsShims = Target.binaryTarget(
    name: "OpenCoreGraphicsShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.3/OpenCoreGraphicsShims.xcframework.zip",
    checksum: "9eed5f41de975c21bc64308a5149d25920339230372c1638fd0d15fe8acf5a13"
)

let openObservation = Target.binaryTarget(
    name: "OpenObservation",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.3/OpenObservation.xcframework.zip",
    checksum: "7ec692df96b12bbbd004dd6b5ed81ebe58754a2d985872d5b21f2f515d3323bb"
)

let openQuartzCoreShims = Target.binaryTarget(
    name: "OpenQuartzCoreShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.3/OpenQuartzCoreShims.xcframework.zip",
    checksum: "606322a2bf754f13d20b75d32503d52c2f7392bab664aef6ee08406c47280949"
)

let openRenderBoxShims = Target.binaryTarget(
    name: "OpenRenderBoxShims",
    url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases/download/0.17.3/OpenRenderBoxShims.xcframework.zip",
    checksum: "5790ec9e689c5d39120d8d31a8e3fafa40413e86f47e984076e0c79adfb997c2"
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
