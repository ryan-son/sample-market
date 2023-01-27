import APIClient
import CacheStorage
import Foundation

public final class ImageCacheStorage: CacheStorage.Cache {

  private let cache: LRUCacheStorage
  private let queue: DispatchQueue

  public init(
    cache: LRUCacheStorage = LRUCacheStorage(
      diskCache: LRUDiskCache(maxSize: 40 * 1024 * 1024),
      memoryCache: LRUMemoryCache(maxSize: 500 * 1024 * 1024)
    ),
    queue: DispatchQueue = DispatchQueue(label: "com.image-cache-storage")
  ) {
    self.cache = cache
    self.queue = queue
  }

  public func store(_ data: Data, for key: String) {
    queue.async {
      self.cache.store(data, for: key)
    }
  }

  public func retrieve(for key: String) -> Data? {
    var cached: Data?
    queue.sync { cached = cache.retrieve(for: key) }
    return cached
  }

  public func remove(for key: String) {
    queue.async {
      self.cache.remove(for: key)
    }
  }

  public func removeAll() {
    queue.async {
      self.cache.removeAll()
    }
  }
}
