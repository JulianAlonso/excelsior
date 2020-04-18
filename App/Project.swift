import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "Excelsior",
                      targets: [
                          Target(name: "App",
                                 platform: .iOS,
                                 product: .app,
                                 bundleId: "com.excelsior.excelsior",
                                 deploymentTarget: .iOS(targetVersion: "10.0", devices: .iphone),
                                 infoPlist: "Config/App.plist",
                                 sources: ["Sources/**"],
                                 resources: ["Resources/**"],
                                 actions: [],
                                 dependencies: []),
                          Target(name: "Tests",
                                 platform: .iOS,
                                 product: .unitTests,
                                 bundleId: "com.excelsior.excelsior-tests",
                                 deploymentTarget: .iOS(targetVersion: "10.0", devices: .iphone),
                                 infoPlist: .default,
                                 sources: ["Tests/**"],
                                 dependencies: [
                                     .target(name: "App")
                                 ]),
                          Target(name: "UITest",
                                 platform: .iOS,
                                 product: .uiTests,
                                 bundleId: "com.excelsior.app-uitests",
                                 deploymentTarget: .iOS(targetVersion: "10.0", devices: .iphone),
                                 infoPlist: .default,
                                 sources: ["UITests"],
                                 dependencies: [
                                     .target(name: "App")
                                 ])
                      ])
