import ProjectDescription

extension Project {
    public static func module(name: String, dependencies: [TargetDependency] = []) -> Project {
        Project(name: name,
                targets: [
                    Target(name: name,
                            platform: .iOS,
                            product: .framework,
                            bundleId: "com.excelsior.\(name)",
                            deploymentTarget: .iOS(targetVersion: "10.0", devices: .iphone),
                            infoPlist: .default,
                            sources: ["Sources/**"],
                            dependencies: dependencies),
                    Target(name: "\(name)UnitTests",
                            platform: .iOS,
                            product: .unitTests,
                            bundleId: "com.excelsior.\(name)Tests",
                            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
                            infoPlist: .default,
                            sources: "Tests/**",
                            dependencies: [
                                .target(name: "\(name)"),
                            ])
                ])
    }
}
