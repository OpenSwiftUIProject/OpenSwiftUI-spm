# Example

A minimal iOS, macOS, and visionOS app demonstrating OpenSwiftUI binary framework
integration through an Xcode-native Swift package dependency. Tuist only
generates the Example project and workspace.

## Prerequisites

- [mise](https://mise.jdx.dev/) installed
- Xcode 26.6+

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

To use locally built OpenSwiftUI XCFrameworks, quit Xcode completely first.
Then export the absolute path to their containing directory and launch
Xcode from the same shell:

```bash
export OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH=/path/to/OpenSwiftUI/build
"$(dirname "$(xcode-select -p)")/MacOS/Xcode" "$PWD/Example.xcworkspace"
```

## visionOS

The visionOS target requires visionOS 2.0 or later and XCFrameworks with visionOS
device and simulator slices. The 0.23.1 binaries do not include these slices.
Until a release includes them, use `OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH` with
locally built XCFrameworks.

## Notes

- The generated `.xcodeproj` and `.xcworkspace` are gitignored — always regenerate via `tuist generate`.
