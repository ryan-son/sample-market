//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Geonhee on 2023/01/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "MarketClient",
  targetTypes: [.unitTest],
  dependencies: [
    .project(target: "APIClient", path: .relativeToRoot("Modules/APIClient")),
    .project(target: "SMFoundation", path: .relativeToRoot("Modules/SMFoundation")),
    .project(target: "SharedModels", path: .relativeToRoot("Modules/SharedModels"))
  ],
  additionalFiles: [
    "Sources/MarketItemListSampleResponse.json"
  ]
)
