import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "MarvelClient",
                             dependencies: [.core, .support, .networking],
                             packages: [.networking])
