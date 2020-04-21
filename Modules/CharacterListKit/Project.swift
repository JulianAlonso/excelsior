import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "CharacterListKit",
                             dependencies: [.displayKit, .marvelClient],
                             packages: [.kingfisher],
                             resources: .storyboards, .assets)
