import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "Support",
                             dependencies: [.promises],
                             packages: [.promises])
