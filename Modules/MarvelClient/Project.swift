import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "MarvelClient",
                             dependencies: [.support, .networking],
                             packages: [.networking])
