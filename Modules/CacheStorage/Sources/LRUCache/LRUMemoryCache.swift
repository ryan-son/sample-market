//
//  MemoryCache.swift
//  ImageCacheStorage
//
//  Created by Geonhee on 2023/01/25.
//

import Foundation

public final class LRUMemoryCache: LRUCache {

  private let cache: NSCache<NSString, NSData>
  let maxSize: Int
  var totalSize: Int {
    return cache.countLimit
  }

  public init(
    cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>(),
    maxSize: Int
  ) {
    self.cache = cache
    self.cache.totalCostLimit = maxSize
    self.maxSize = maxSize
  }

  public func store(_ data: Data, for key: String) {
    let nsData = data as NSData
    cache.setObject(nsData, forKey: key as NSString, cost: nsData.length)
  }

  public func retrieve(for key: String) -> Data? {
    return cache.object(forKey: key as NSString) as Data?
  }

  public func remove(for key: String) {
    cache.removeObject(forKey: key as NSString)
  }

  public func removeLeastRecentlyUsed() {
    // NSCache 기본 정책이 LRU임
  }

  public func removeAll() {
    cache.removeAllObjects()
  }
}
