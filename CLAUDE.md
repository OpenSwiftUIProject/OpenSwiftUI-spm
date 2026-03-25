# OpenSwiftUI-spm

Lightweight SPM package distributing precompiled XCFrameworks from [OpenSwiftUI](https://github.com/OpenSwiftUIProject/OpenSwiftUI) releases.

## Project Structure

- `Package.swift` — SPM manifest with 7 binary targets pointing to xcframework zips from OpenSwiftUI releases
- `Package.swift.template` — Template with `{{VERSION}}` and `{{CHECKSUM_*}}` placeholders, used by OpenSwiftUI's release workflow to auto-generate Package.swift
- `Tests/` — Smoke test using Swift Testing (`@Test`)
- `Example/` — Tuist-based example app (iOS + macOS). Run `tuist install && tuist generate` inside `Example/`

## Release Workflow

Package.swift is auto-updated by OpenSwiftUI's release workflow:
1. OpenSwiftUI tags a release → builds + signs xcframeworks → publishes release
2. Release workflow clones this repo, renders `Package.swift.template` with version + checksums, commits, pushes, and tags

To update manually: render `Package.swift.template` with the version and checksums from the [release page](https://github.com/OpenSwiftUIProject/OpenSwiftUI/releases).

## Code Signing

XCFrameworks are signed with a self-signed "OpenSwiftUI" certificate. The `.p12` is stored in the private [certificates](https://github.com/OpenSwiftUIProject/certificates) repo. Signing secrets are org-level GitHub secrets.

## Key Commands

```bash
# Verify Package.swift parses
swift package dump-package

# Run tests (requires macOS 15+ or iOS 18+ simulator)
swift test

# Example app
cd Example && tuist install && tuist generate
```
