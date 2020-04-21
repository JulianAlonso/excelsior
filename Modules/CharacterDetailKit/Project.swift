import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "CharacterDetailKit",
                             dependencies: [.displayKit, .marvelClient],
                             resources: .xibs, .storyboards, .assets)
