//
//  UINavigationController+Extension.swift
//  CoreLibraries
//
//  Created by Geonhee on 2022/08/21.
//  Copyright © 2022 APTNER Inc. All rights reserved.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }

  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
