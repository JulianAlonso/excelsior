import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "AppCore",
                             dependencies: [
                                .characterListKit,
                                .characterDetailKit
                             ])
