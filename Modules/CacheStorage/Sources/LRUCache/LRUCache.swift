//
//  LRUCache.swift
//  ImageCacheStorage
//
//  Created by Geonhee on 2023/02/05.
//

import Foundation

protocol LRUCache {
  associatedtype Key

  func store(_ data: Data, for key: Key)
  func retrieve(for key: Key) -> Data?
  func remove(for key: Key)
  func removeLeastRecentlyUsed()
  func removeAll()
}
