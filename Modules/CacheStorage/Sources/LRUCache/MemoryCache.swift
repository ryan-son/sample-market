//
//  MemoryCache.swift
//  ImageCacheStorage
//
//  Created by Geonhee on 2023/01/25.
//

import Foundation

public final class LRUMemoryCache<Key: AnyObject>: LRUCache {

  private let cache: NSCache<Key, NSData>
  private let maximumSize: Int

  public init(
    cache: NSCache<Key, NSData> = NSCache<Key, NSData>(),
    maximumSize: Int
  ) {
    self.cache = cache
    self.maximumSize = maximumSize
  }

  public func store(_ data: Data, for key: Key) {
    let nsData = data as NSData
    cache.setObject(nsData, forKey: key, cost: nsData.length)
  }

  public func retrieve(for key: Key) -> Data? {
    return cache.object(forKey: key) as Data?
  }

  public func remove(for key: Key) {
    cache.removeObject(forKey: key)
  }

  func removeLeastRecentlyUsed() {
    // NSCache 기본 정책이 LRU임
  }

  func removeAll() {
    cache.removeAllObjects()
  }
}