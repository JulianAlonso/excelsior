import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "CharacterDetailKit",
                             dependencies: [.displayKit, .core],
                             resources: .xibs, .storyboards, .assets)
