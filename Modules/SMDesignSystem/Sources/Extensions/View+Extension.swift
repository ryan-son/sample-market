//
//  View+Extension.swift
//  ResourcePackage
//
//  Created by Geonhee on 2022/08/25.
//  Copyright © 2022 Cimille Inc. All rights reserved.
//

import PureSwiftUI
import SwiftUI

func registerAllFontsIfNeeded() {
  if UIFont.fontNames(forFamilyName: "Pretendard").isEmpty {
    Font.registerAllFonts()
  }
}

// MARK: - Font for View

extension View {

  func scalingFont(
    style: CimilleFontStyle,
    weight: Font.PretendardStyle
  ) -> some View {
    registerAllFontsIfNeeded()
    let scaledSize = UIFontMetrics.default.scaledValue(for: style.size)
    return font(.custom(weight.rawValue, size: scaledSize))
  }

  public func aptnBoldFont(_ style: CimilleFontStyle) -> some View {
    return scalingFont(style: style, weight: .bold)
  }

  public func aptnSemiBoldFont(_ style: CimilleFontStyle) -> some View {
    return scalingFont(style: style, weight: .semiBold)
  }

  public func aptnRegularFont(_ style: CimilleFontStyle) -> some View {
    return scalingFont(style: style, weight: .regular)
  }
}

// MARK: - Adaptive Padding

extension View {

  public func adaptiveVPadding(_ verticalPadding: CGFloat) -> some View {
    return padding(.vertical, adaptiveHeightValue(verticalPadding))
  }

  public func adaptiveHPadding(_ horizontalPadding: CGFloat) -> some View {
    return padding(.horizontal, adaptiveWidthValue(horizontalPadding))
  }

  public func adaptivePadding(
    h horizontalPadding: CGFloat,
    v verticalPadding: CGFloat
  ) -> some View {
    return padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
  }
}

// MARK: - Adaptive Sizing

extension View {
  public func adaptiveFrame(
    _ size: CGFloat,
    _ alignment: Alignment = .center
  ) -> some View {
    return adaptiveFrame(size, size, alignment)
  }

  public func adaptiveFrame(
    _ width: CGFloat,
    _ height: CGFloat,
    _ alignment: Alignment = .center
  ) -> some View {
    return frame(
      width: adaptiveWidthValue(width),
      height: adaptiveHeightValue(height),
      alignment: alignment
    )
  }

  public func adaptiveWidth(
    _ width: CGFloat,
    _ alignment: Alignment = .center
  ) -> some View {
    return frame(
      width: adaptiveWidthValue(width),
      alignment: alignment
    )
  }

  public func adaptiveHeight(
    _ height: CGFloat,
    _ alignment: Alignment = .center
  ) -> some View {
    return frame(
      height: adaptiveHeightValue(height),
      alignment: alignment
    )
  }
}
