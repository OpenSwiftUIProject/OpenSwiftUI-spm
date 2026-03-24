import ProjectDescription

let project = Project(
    name: "Example",
    targets: [
        .target(
            name: "Example",
            destinations: .iOS,
            product: .app,
            bundleId: "org.OpenSwiftUIProject.OpenSwiftUI-binary.Example",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [
                    "UIColorName": "",
                ],
            ]),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "OpenSwiftUI"),
            ]
        ),
    ]
)
