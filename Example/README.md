# Example

A minimal iOS app demonstrating OpenSwiftUI binary framework integration via Tuist.

## Prerequisites

- [Tuist](https://docs.tuist.io/guides/quick-start/install-tuist) installed
- Xcode 16.4+

## Setup

Run the setup script from this directory:

```bash
./setup.sh
```

The script trusts and installs the root `mise` toolchain, fetches Tuist dependencies, and generates the Xcode workspace. To run the steps manually:

```bash
cd ..
mise trust
mise install
cd Example
tuist install
tuist generate
```

Open the generated `Example.xcworkspace` and run the app on an iOS 18.0+ simulator.

## Notes

- The generated `.xcodeproj` and `.xcworkspace` are gitignored — always regenerate via `tuist generate`.
- The example depends on the root `OpenSwiftUI-spm` package via a local path reference. To use the remote package instead, update `Tuist/Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI-spm", from: "0.18.0"),
]
```
