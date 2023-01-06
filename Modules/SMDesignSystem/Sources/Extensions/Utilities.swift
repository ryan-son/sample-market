//
//  Utilities.swift
//  ResourcePackage
//
//  Created by Geonhee on 2022/08/25.
//  Copyright © 2022 Cimille Inc. All rights reserved.
//

import UIKit

// MARK: - Screen Metric

var screenRect: CGRect {
  return UIScreen.main.bounds
}

// MARK: - Adaptive Sizes

/// 디자인 기준 화면 크기 (390 *844)
private let standardScreenSize = CGSize(width: 390, height: 844)

public func adaptiveHeightValue(_ height: CGFloat) -> CGFloat {
  return (height / standardScreenSize.height) * screenRect.height
}

public func adaptiveWidthValue(_ width: CGFloat) -> CGFloat {
  return (width / standardScreenSize.width) * screenRect.width
}
