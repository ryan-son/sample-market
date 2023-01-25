//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Geonhee on 2023/01/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .framework(
  name: "ImageCacheStorage",
  targetTypes: [.unitTest],
  dependencies: [
    .project(target: "APIClient", path: .relativeToRoot("Modules/APIClient")),
    .project(target: "CacheStorage", path: .relativeToRoot("Modules/CacheStorage"))
  ]
)
