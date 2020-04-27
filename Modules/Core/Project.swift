import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "Core",
                             dependencies: [.storage],
                             packages: [.storage])
