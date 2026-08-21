# Example

A minimal iOS app demonstrating OpenSwiftUI binary framework integration via Tuist.

## Prerequisites

- [mise](https://mise.jdx.dev/) installed
- Xcode 16.4+

## Setup

Run the setup script from this directory:

```bash
./setup.sh
```

The script trusts and installs the Example `mise` toolchain, fetches Tuist dependencies, and generates the Xcode workspace. To run the steps manually:

```bash
mise trust mise.toml
mise install
mise exec -- tuist install
mise exec -- tuist generate --no-open

```

Then open the generated `Example.xcworkspace`.

To use locally built OpenSwiftUI XCFrameworks, set their containing directory
when running the setup script:

```bash
OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH=/path/to/OpenSwiftUI/build ./setup.sh
```

The directory can contain only the frameworks under active development. Any
missing XCFrameworks continue to use the release binaries. The same behavior is
available to other SwiftPM commands through the
`OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH` environment variable. As a convenience,
`./setup.sh --local-xcframeworks /path/to/OpenSwiftUI/build` overrides the
environment variable for that invocation.

## Notes

- The generated `.xcodeproj` and `.xcworkspace` are gitignored — always regenerate via `tuist generate`.
- The example depends on the root `OpenSwiftUI-spm` package via a local path reference. To use the remote package instead, update `Tuist/Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/OpenSwiftUIProject/OpenSwiftUI-spm", from: "0.18.1"),
]
```
