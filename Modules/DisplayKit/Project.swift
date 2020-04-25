import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "DisplayKit",
                             dependencies: [
                                .navigatorKit,
                                .kingfisher
                             ],
                             packages: [
                                .kingfisher
                             ],
                             resources: .xibs, .assets)
