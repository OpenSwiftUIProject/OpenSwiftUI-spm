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

## Security

XCFrameworks are code-signed with a self-signed certificate named "OpenSwiftUI".

Certificate fingerprint (SHA-256):
```
F4:80:B9:8F:2E:D6:D4:A3:6B:32:9D:D9:3C:B3:4F:44:A9:69:CE:E7:12:9F:98:A3:23:75:52:C6:0B:41:EA:79
```

You can verify the signature of a downloaded XCFramework using:

```bash
codesign -dv --verbose=4 OpenSwiftUI.xcframework
```

The `Package.swift` URLs point directly to [official OpenSwiftUI releases](https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases), and SPM verifies the checksum on download.

## License

MIT License. See [LICENSE](LICENSE) for details.
