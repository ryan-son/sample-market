//
//  Text+Extension.swift
//  ResourcePackage
//
//  Created by Geonhee on 2022/08/25.
//  Copyright © 2022 Cimille Inc. All rights reserved.
//

import SwiftUI

// MARK: - Font for Text

extension Text {

  func scalingFont(
    style: CimilleFontStyle,
    weight: Font.PretendardStyle
  ) -> Text {
    registerAllFontsIfNeeded()
    let scaledSize = UIFontMetrics.default.scaledValue(for: style.size)
    return font(.custom(weight.rawValue, size: scaledSize))
  }

  public func aptnBoldFont(_ style: CimilleFontStyle) -> Text {
    return scalingFont(style: style, weight: .bold)
  }

  public func aptnSemiBoldFont(_ style: CimilleFontStyle) -> Text {
    return scalingFont(style: style, weight: .semiBold)
  }

  public func aptnRegularFont(_ style: CimilleFontStyle) -> Text {
    return scalingFont(style: style, weight: .regular)
  }
}
