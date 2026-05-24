# SwiftUI Library Integration

If you maintain a SwiftUI library and want it to build against either Apple's
SwiftUI or OpenSwiftUI, expose the OpenSwiftUI integration as an opt-in package
trait. Package traits are available in SwiftPM starting with Swift 6.1
(SE-0450), so the manifest that declares the trait must use
`// swift-tools-version: 6.1` or newer.

Following the pattern used by
[ScreenShieldKit](https://github.com/Kyle-Ye/ScreenShieldKit/blob/main/Package.swift),
declare an `OpenSwiftUI` trait, make the OpenSwiftUI product dependency
conditional on that trait, and define an internal compilation condition such as
`OPENSWIFTUI` for your source files:

```swift
// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "YourSwiftUILibrary",
    platforms: [
        // Keep your normal SwiftUI deployment targets here.
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "YourSwiftUILibrary", targets: ["YourSwiftUILibrary"]),
    ],
    traits: [
        .trait(
            name: "OpenSwiftUI",
            description: "Enable OpenSwiftUI-backed SwiftUI extensions."
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI-spm.git",
            from: "0.18.1"
        ),
    ],
    targets: [
        .target(
            name: "YourSwiftUILibrary",
            dependencies: [
                .product(
                    name: "OpenSwiftUI",
                    package: "OpenSwiftUI-spm",
                    condition: .when(traits: ["OpenSwiftUI"])
                ),
            ],
            swiftSettings: [
                .define("OPENSWIFTUI", .when(traits: ["OpenSwiftUI"])),
            ]
        ),
    ]
)
```

The trait name is part of your public package configuration. The
`OPENSWIFTUI` define is the source-level flag your package uses internally.
Consumers enable the trait on your package dependency:

```swift
dependencies: [
    .package(
        url: "https://github.com/YourOrg/YourSwiftUILibrary.git",
        from: "1.0.0",
        traits: ["OpenSwiftUI"]
    ),
]
```

If your package also declares default traits and the consumer wants those
defaults plus OpenSwiftUI, they should include `.defaults` explicitly:

```swift
traits: [.defaults, "OpenSwiftUI"]
```

In your source, import only the framework that matches the selected build path.
Use this form when the API exists only for OpenSwiftUI builds:

```swift
#if OPENSWIFTUI
import OpenSwiftUI

extension View {
    // OpenSwiftUI-only extensions.
}
#endif
```

Use this form when the same public API should be available in both SwiftUI and
OpenSwiftUI builds:

```swift
#if OPENSWIFTUI
import OpenSwiftUI
#else
import SwiftUI
#endif

extension View {
    // Shared API implemented against the selected framework.
}
```

When `traits:` is specified on a dependency, SwiftPM uses exactly that trait set
for the dependency. Add `.defaults` when you want to keep a package's default
traits. Also keep the trait additive from the user's point of view: enabling
`OpenSwiftUI` should add or redirect the implementation without unexpectedly
removing public API.

OpenSwiftUI's binary frameworks currently support iPhone Simulator on iOS 18.0+
and macOS 15.0+. Your library may keep broader SwiftUI platform support for the
default build, but the `OpenSwiftUI` trait should only be enabled on platforms
supported by the OpenSwiftUI binary package.
