import APIClient
import CacheStorage
import Foundation

public final class ImageCacheStorage: CacheStorage.Cache {

  private let cache: LRUCacheStorage

  public init(
    cache: LRUCacheStorage = LRUCacheStorage(
      diskCache: LRUDiskCache(maxSize: 40 * 1024 * 1024),
      memoryCache: LRUMemoryCache(maxSize: 500 * 1024 * 1024)
    )
  ) {
    self.cache = cache
  }

  public func store(_ data: Data, for key: String) {
    cache.store(data, for: key)
  }

  public func retrieve(for key: String) -> Data? {
    return cache.retrieve(for: key)
  }

  public func remove(for key: String) {
    cache.remove(for: key)
  }

  public func removeAll() {
    cache.removeAll()
  }
}
