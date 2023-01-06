//
//  AppFont.swift
//  ResourcePackage
//
//  Created by Geonhee on 2022/06/22.
//

import SwiftUI

public extension Font {
  static func registerAllFonts() {
    let fonts = Bundle.module.urls(forResourcesWithExtension: "otf", subdirectory: nil)
    fonts?.forEach { CTFontManagerRegisterFontsForURL($0 as CFURL, .process, nil) }
  }
}

public enum CimilleFontStyle: CaseIterable {
  case display1
  case headline1
  case headline2
  case headline3
  case headline4
  case subtitle1
  case subtitle2
  case subtitle3
  case body1
  case body2
  case body3
  case body4
  case badge1
  case badge2
}

public extension CimilleFontStyle {
  var size: CGFloat {
    switch self {
    case .display1:
      return 36
    case .headline1:
      return 32
    case .headline2:
      return 28
    case .headline3:
      return 24
    case .headline4:
      return 22
    case .subtitle1:
      return 20
    case .subtitle2:
      return 18
    case .subtitle3:
      return 16
    case .body1:
      return 16
    case .body2:
      return 14
    case .body3:
      return 13
    case .body4:
      return 12
    case .badge1:
      return 11
    case .badge2:
      return 10
    }
  }
}
