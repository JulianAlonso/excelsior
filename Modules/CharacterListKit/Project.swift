import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: "CharacterListKit",
                             dependencies: [.displayKit, .dataProvidersKit],
                             packages: [.kingfisher],
                             resources: .storyboards, .assets)
