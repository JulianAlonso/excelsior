import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "DisplayKit",
                             dependencies: [
                                .navigatorKit,
                                .kingfisher,
                                .injection
                             ],
                             packages: [
                                .kingfisher,
                                .injection
                             ],
                             resources: .xibs, .assets)
