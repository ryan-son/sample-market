//
//  CacheStorage.swift
//  CacheStorage
//
//  Created by Geonhee on 2023/01/25.
//

import Foundation

public protocol Cache {
  associatedtype Key

  func store(_ data: Data, for key: Key)
  func retrieve(for key: Key) -> Data?
  func remove(for key: Key)
  func removeAll()
}

public protocol LRUCache: Cache {
  func removeLeastRecentlyUsed()
}
