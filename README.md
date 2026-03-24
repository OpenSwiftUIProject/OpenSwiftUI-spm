# OpenSwiftUI (Binary)

A lightweight Swift Package that provides precompiled XCFrameworks from [OpenSwiftUI](https://github.com/OpenSwiftUIProject/OpenSwiftUI) releases.

This avoids the need to clone and compile the full OpenSwiftUI source repository.

## Installation

### Via Xcode

1. In Xcode, select **File > Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/OpenSwiftUIProject/OpenSwiftUI-binary`
3. Select the version you want to use

### Via Package.swift

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI-binary", from: "0.17.0"),
]
```

Then add `"OpenSwiftUI"` to the target's dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "OpenSwiftUI", package: "OpenSwiftUI-binary"),
    ]
),
```

## Platform Support

Currently supports:
- iPhone Simulator — iOS 18.5+
- macOS 15.5+

## Included Frameworks

| Framework | Description |
|-----------|-------------|
| OpenSwiftUI | Main framework |
| OpenSwiftUICore | Core types and utilities |
| OpenAttributeGraphShims | AttributeGraph shim layer |
| OpenCoreGraphicsShims | CoreGraphics shim layer |
| OpenObservation | Observation framework support |
| OpenQuartzCoreShims | QuartzCore shim layer |
| OpenRenderBoxShims | RenderBox shim layer |

## License

MIT License. See [LICENSE](LICENSE) for details.
