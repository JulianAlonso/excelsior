import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "Core",
                             dependencies: [.storage, .support, .networkingPromises],
                             packages: [.storage, .networking])
