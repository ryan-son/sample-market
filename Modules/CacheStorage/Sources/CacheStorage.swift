//
//  CacheStorage.swift
//  CacheStorage
//
//  Created by Geonhee on 2023/01/25.
//

import Foundation

protocol CacheStorage {
  func data<Key>(for key: Key) async -> Data?
  func store<Key>(data: Data, for key: Key)
}
