//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Geonhee on 2023/01/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "MarketHome",
  dependencies: [
    .project(target: "MarketHomeCore", path: .relativeToRoot("Modules/MarketHomeCore")),
  ]
)
