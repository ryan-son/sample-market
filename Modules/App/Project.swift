import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .app(
  name: "App",
  dependencies: [
    .project(target: "SMDesignSystem", path: .relativeToRoot("Modules/ResourcePackage"))
  ],
  additionalFiles: [
    ".swiftlint.yml"
  ]
)
