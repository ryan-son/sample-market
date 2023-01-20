//
//  Parameters.swift
//  APIClient
//
//  Created by Geonhee on 2023/01/20.
//

import Foundation

public struct Parameters {
  public var values: [String: Any]

  public init(values: [String: Any]) {
    self.values = filterNil(values)
  }

  public func toQueryItems() -> [URLQueryItem] {
    return values.map { (key, value) in
      return URLQueryItem(name: key, value: "\(value)")
    }
  }
}

private func filterNil(_ dictionary: [String: Any?]) -> [String: Any] {
    var newDictionary: [String: Any] = [:]
    for (key, value) in dictionary {
        guard let value = value else { continue }
        newDictionary[key] = value
    }
    return newDictionary
}
