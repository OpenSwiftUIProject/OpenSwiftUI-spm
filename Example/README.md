# Example

A minimal iOS app demonstrating OpenSwiftUI binary framework integration via Tuist.

## Prerequisites

- [Tuist](https://docs.tuist.io/guides/quick-start/install-tuist) installed
- Xcode 16.4+

## Setup

1. Install Tuist if you haven't already:

```bash
curl -Ls https://install.tuist.io | bash
```

2. Fetch external dependencies:

```bash
cd Example
tuist install
```

3. Generate the Xcode project:

```bash
tuist generate
```

4. Open the generated `Example.xcworkspace` and run the app on an iOS 18.5+ simulator.

## Notes

- The generated `.xcodeproj` and `.xcworkspace` are gitignored — always regenerate via `tuist generate`.
- The example depends on the root `OpenSwiftUI-binary` package via a local path reference. To use the remote package instead, update `Tuist/Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI-binary", from: "0.17.0"),
]
```
