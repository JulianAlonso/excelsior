import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "CharacterListKit",
                             dependencies: [.displayKit, .core],
                             packages: [.kingfisher],
                             resources: .storyboards, .assets)
