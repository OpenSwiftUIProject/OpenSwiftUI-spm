import ProjectDescription

let project = Project(
    name: "Example",
    targets: [
        .target(
            name: "Example",
            destinations: [.iPhone, .iPad, .mac],
            product: .app,
            bundleId: "org.OpenSwiftUIProject.OpenSwiftUI-spm.Example",
            deploymentTargets: .multiplatform(iOS: "18.5", macOS: "15.5"),
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
