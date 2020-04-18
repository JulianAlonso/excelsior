import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "CharacterDetailKit",
                             dependencies: [.displayKit, .dataProvidersKit],
                             resources: .xibs, .storyboards, .assets)
