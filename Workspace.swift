//
//  Workspace.swift
//  SampleMarketManifests
//
//  Created by Geonhee on 2023/01/06.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Workspace

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let workspace = Workspace(
  name: "SampleMarket",
  projects: [
    "Modules/App",
    "Modules/SMDesignSystem",
  ],
  additionalFiles: []
)
