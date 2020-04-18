import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "CharacterListKit",
                             dependencies: [.displayKit, .dataProvidersKit],
                             resources: .storyboards, .assets)
