import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "DisplayKit",
                             dependencies: [.kingfisher],
                             packages: [.kingfisher],
                             resources: .xibs, .assets)
