//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Geonhee on 2023/01/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .staticLibrary(
  name: "MarketHomeCore",
  targetTypes: [.unitTest],
  dependencies: [
    .project(target: "MarketClient", path: .relativeToRoot("Modules/MarketClient")),
    .project(target: "SharedModels", path: .relativeToRoot("Modules/SharedModels"))
  ]
)
