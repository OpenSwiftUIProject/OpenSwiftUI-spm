import ProjectDescription

let project = Project(
    name: "Example",
    targets: [
        .target(
            name: "Example",
            destinations: .iOS,
            product: .app,
            bundleId: "org.OpenSwiftUIProject.Example",
            deploymentTargets: .iOS("18.0"),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "OpenSwiftUI"),
            ]
        ),
    ]
)
