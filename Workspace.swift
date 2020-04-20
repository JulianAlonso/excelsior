import ProjectDescription

let workspace = Workspace(name: "Excelsior",
                          projects: ["App"],
                          additionalFiles: [
                              .folderReference(path: "Libraries/Promises"),
                              .folderReference(path: "Libraries/Networking")
                          ])
