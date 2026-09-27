# SwiftPM Macro Packaging

Decision recorded on 2026-09-27.

## Current Decision

Both source mirroring and a separate package dependency are valid ways to
distribute macro implementations. Use source mirrors in `OpenSwiftUI-spm` for
now. A switch to separate dependencies remains an option for a later change.

At `OpenSwiftUI-spm` revision `8e57711`, both `OpenSwiftUIMacros` and
`OpenObservationMacros` are source macro targets. The release workflow copies
`Sources/OpenSwiftUIMacros` from the OpenSwiftUI release source and
`Sources/OpenObservationMacros` from the OpenObservation revision pinned in that
release's `Package.resolved`. Edit the canonical sources, not the generated
mirrors. See the package's
[macro distribution documentation](../README.md#macro-distribution).

## Options by Component

| Component | Mirror | Separate dependency |
| --- | --- | --- |
| OpenObservation | Keep mirroring `OpenObservationMacros` into the binary distribution package. | Depend on the OpenObservation package. Because the distribution also includes an OpenObservation binary, rename the affected `binaryTarget` and update its references to avoid target-name conflicts. Validate this arrangement before switching. |
| OpenSwiftUIMacros | Keep mirroring the macro implementation from OpenSwiftUI. | Extract the macro package into an independent repository, or keep it as a child package in OpenSwiftUI and publish a mirror repository for dependency consumers. |

Mirrors require the release workflow to keep source and binary versions aligned.
Separate dependencies require a package boundary and compatible version pins.
Neither approach is ruled out by the current decision.

## Xcode Prebuilts Constraint

[swift-build issue #1642](https://github.com/swiftlang/swift-build/issues/1642)
reports that Xcode can link a macro's macOS testable object into an iOS Simulator
test bundle when the test, library, and macro targets are in the same package
and SwiftSyntax prebuilts are enabled. This is an additional constraint for the
OpenSwiftUIMacros package layout.

For affected builds, the options are:

- Disable prebuilts with `-IDEPackageEnablePrebuilts=NO`. SwiftSyntax then builds
  from source.
- Put the macro in a separate package. The issue confirms that a local child
  package works with prebuilts enabled; an independent repository is another
  layout to consider.

Source mirroring does not by itself remove this package-layout constraint.

## Before Switching to Separate Dependencies

- [ ] Validate the OpenObservation dependency with the renamed `binaryTarget`.
- [ ] Choose an independent OpenSwiftUIMacros repository or a child package with
  a mirror repository, and verify the affected Xcode test configuration.
- [ ] Decide how to package `OpenSwiftUIExtension` and provide its macro
  dependencies if the packages move to independent repositories.
