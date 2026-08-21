// swift-tools-version: 6.0

import PackageDescription

#if TUIST
import ProjectDescription

let openSwiftUISigningFingerprint = "F480B98F2ED6D4A36B329DD93CB34F44A969CEE7129F98A3237552C60B41EA79"
let usesLocalXCFrameworks = !Environment.openswiftuiLocalXcframeworksPath
    .getString(default: "")
    .isEmpty
let expectedSignatures: [String: XCFrameworkSignature] = usesLocalXCFrameworks ? [:] : [
    "OpenSwiftUI": .selfSigned(fingerprint: openSwiftUISigningFingerprint),
    "OpenSwiftUICore": .selfSigned(fingerprint: openSwiftUISigningFingerprint),
    "OpenAttributeGraphShims": .selfSigned(fingerprint: openSwiftUISigningFingerprint),
    "OpenCoreGraphicsShims": .selfSigned(fingerprint: openSwiftUISigningFingerprint),
    "OpenObservation": .selfSigned(fingerprint: openSwiftUISigningFingerprint),
    "OpenQuartzCoreShims": .selfSigned(fingerprint: openSwiftUISigningFingerprint),
    "OpenRenderBoxShims": .selfSigned(fingerprint: openSwiftUISigningFingerprint),
]

let packageSettings = PackageSettings(
    expectedSignatures: expectedSignatures
)
#endif

let package = Package(
    name: "ExampleDependencies",
    dependencies: [
        .package(path: "../../"),
    ]
)
