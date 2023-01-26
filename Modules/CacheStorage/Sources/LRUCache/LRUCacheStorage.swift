//
//  LRUCacheStorage.swift
//  CacheStorage
//
//  Created by Geonhee on 2023/01/26.
//

import Foundation

public final class LRUCacheStorage: LRUCache {

  private let diskCache: LRUDiskCache
  private let memoryCache: LRUMemoryCache

  public init(
    diskCache: LRUDiskCache,
    memoryCache: LRUMemoryCache
  ) {
    self.diskCache = diskCache
    self.memoryCache = memoryCache
  }

  func store(_ data: Data, for key: String) {
    memoryCache.store(data, for: key)
    diskCache.store(data, for: key)
  }

  func retrieve(for key: String) -> Data? {
    if let data = memoryCache.retrieve(for: key) {
      return data
    } else if let data = diskCache.retrieve(for: key) {
      return data
    }
    return nil
  }

  func remove(for key: String) {
    memoryCache.remove(for: key)
    diskCache.remove(for: key)
  }

  func removeLeastRecentlyUsed() {
    // NSCache는 기본 정책이 LRU이므로 정의할 필요 없음
    // if diskCache totalSize > diskCache maxSize
    // diskCache.removeLeastRecentlyUsed()
  }

  func removeAll() {
    memoryCache.removeAll()
    diskCache.removeAll()
  }
}
