import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "App",
  dependencies: [
    .project(target: "MarketHome", path: .relativeToRoot("Modules/MarketHome"))
  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
