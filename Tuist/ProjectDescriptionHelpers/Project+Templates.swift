import ProjectDescription

// MARK: - Versions

public let appVersion: InfoPlist.Value = "0.1.0"
public let buildNumber: InfoPlist.Value = "1"
public let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: .iphone)

// MARK: - Helpers

extension Project {

  static let bundleIdPrefix: String = "com.ryan-son"

  public static func app(
    name: String,
    dependencies: [TargetDependency],
    packages: [Package] = [],
    additionalFiles: [FileElement] = []
  ) -> Project {
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: .app,
      bundleId: "\(bundleIdPrefix).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: .app(version: appVersion, buildNumber: buildNumber),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      entitlements: nil,
      scripts: [.appSwiftLint],
      dependencies: dependencies,
      settings: nil,
      coreDataModels: [],
      launchArguments: [],
      additionalFiles: []
    )
    return Project(
      name: name,
      packages: packages,
      targets: [mainTarget],
      additionalFiles: additionalFiles
    )
  }

  public static func framework(
    name: String,
    targetTypes: [DynamicFrameworkTargetType] = [],
    dependencies: [TargetDependency] = [],
    packages: [Package] = [],
    additionalFiles: [FileElement] = []
  ) -> Project {
    var projectTargets: [Target] = []
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: .framework,
      bundleId: "\(bundleIdPrefix).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Sources/**"],
      scripts: [.moduleSwiftLint],
      dependencies: dependencies,
      additionalFiles: additionalFiles
    )
    projectTargets.append(mainTarget)

    if targetTypes.contains(.unitTest) {
      let unitTestTarget = Target(
        name: "\(name)Tests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "\(bundleIdPrefix).\(name)Tests",
        deploymentTarget: deploymentTarget,
        infoPlist: .default,
        sources: ["Tests/Sources/**", "Tests/Resources/**"],
        dependencies: [
          .target(name: name),
          .xctest
        ]
      )
      projectTargets.append(unitTestTarget)
    }

    if targetTypes.contains(.preview) {
      let previewAppTarget = Target(
        name: "\(name)PreviewApp",
        platform: .iOS,
        product: .app,
        bundleId: "\(bundleIdPrefix).\(name)PreviewApp",
        deploymentTarget: deploymentTarget,
        infoPlist: .app(version: appVersion, buildNumber: buildNumber),
        sources: ["Preview/Sources/**"],
        resources: ["Preview/Resources/**"],
        scripts: [.moduleSwiftLint],
        dependencies: [
          .target(name: name),
        ]
      )
      projectTargets.append(previewAppTarget)
    }
    return Project(
      name: name,
      options: .options(disableSynthesizedResourceAccessors: true),
      packages: packages,
      targets: projectTargets
    )
  }

  public static func designSystemFramework(
    name: String,
    dependencies: [TargetDependency] = [],
    packages: [Package] = [],
    additionalFiles: [FileElement] = []
  ) -> Project {
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: .framework,
      bundleId: "\(bundleIdPrefix).\(name)",
      deploymentTarget: deploymentTarget,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: [.moduleSwiftLint, .swiftGen],
      dependencies: dependencies,
      additionalFiles: additionalFiles
    )
    return Project(
      name: name,
      options: .options(disableSynthesizedResourceAccessors: true),
      packages: packages,
      targets: [mainTarget]
    )
  }

  public static func staticLibrary(
    name: String,
    targetTypes: [StaticLibraryTargetType] = [],
    dependencies: [TargetDependency] = [],
    packages: [Package] = []
  ) -> Project {
    var projectTargets: [Target] = []
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: .staticLibrary,
      bundleId: "\(bundleIdPrefix).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Sources/**"],
      scripts: [.moduleSwiftLint],
      dependencies: dependencies
    )
    projectTargets.append(mainTarget)

    if targetTypes.contains(.unitTest) {
      let testTarget = Target(
        name: "\(name)Tests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "\(bundleIdPrefix).\(name)Tests",
        deploymentTarget: deploymentTarget,
        infoPlist: .default,
        sources: ["Tests/Sources/**", "Tests/Resources/**"],
        dependencies: [.target(name: name)]
      )
      projectTargets.append(testTarget)
    }
    return Project(
      name: name,
      options: .options(disableSynthesizedResourceAccessors: true),
      packages: packages,
      targets: projectTargets
    )
  }
}

extension TargetScript {
  static let appSwiftLint: Self = .pre(script: Script.appSwiftLint, name: "SwiftLint")
  static let moduleSwiftLint: Self = .pre(script: Script.moduleSwiftLint, name: "SwiftLint")
  static let swiftGen: Self = .pre(script: Script.swiftGen, name: "SwiftGen")
}

extension InfoPlist {

  static func app(
    version: InfoPlist.Value,
    buildNumber: InfoPlist.Value
  ) -> Self {
    return .extendingDefault(
      with: [
        "CFBundleShortVersionString": version,
        "CFBundleVersion": buildNumber,
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen"
      ]
    )
  }
}

extension TargetScript.Script {

  static let appSwiftLint = """
  if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
  fi

  export PATH

  if which swiftlint >/dev/null; then
    swiftlint --fix && swiftlint
  else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  fi
  """

  static let moduleSwiftLint = """
  if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
  fi

  export PATH

  if which swiftlint >/dev/null; then
    CONFIG_PATH="${SRCROOT}/../../App/.swiftlint.yml"
    swiftlint --fix --config "${CONFIG_PATH}" && swiftlint --config "${CONFIG_PATH}"
  else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  fi
  """

  static let swiftGen = """
  if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
  fi

  export PATH

  if which swiftgen >/dev/null; then
    swiftgen run xcassets "${SRCROOT}/Resources/Colors.xcassets" "${SRCROOT}/Resources/Images.xcassets" -p "${SRCROOT}/Templates/Assets.stencil" -o "${SRCROOT}/Sources/Assets+Generated.swift"
  else
    echo "warning: SwiftGen is not installed.
  fi
  """
}
