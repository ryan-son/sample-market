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
    "Modules/APIClient",
    "Modules/App",
    "Modules/CoreLibraries",
    "Modules/MarketClient",
    "Modules/MarketHome",
    "Modules/MarketHomeCore",
    "Modules/SMDesignSystem",
    "Modules/SMFoundation",
    "Modules/SharedModels",
  ],
  additionalFiles: []
)
