//
//  Occupiable.swift
//  SMFoundation
//
//  Created by Geonhee on 2023/01/21.
//

public protocol Occupiable {
  var isEmpty: Bool { get }
  var isNotEmpty: Bool { get }
}

public extension Occupiable {
  var isNotEmpty: Bool {
    return !isEmpty
  }
}

extension Array: Occupiable {}
