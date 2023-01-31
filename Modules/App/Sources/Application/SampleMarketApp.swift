import APIClient
import CacheStorage
import ImageClient
import ImageCacheStorage
import MarketClient
import MarketHome
import MarketHomeCore
import SwiftUI

@main
struct SampleMarketApp: App {
  var body: some Scene {
    WindowGroup {
      let diskCache = LRUDiskCache(maxSize: 50 * 1024 * 1024)
      let memoryCache = LRUMemoryCache(maxSize: 300 * 1024 * 1024)
      let cacheStorage = LRUCacheStorage(diskCache: diskCache, memoryCache: memoryCache)
      let imageCacheStorage = ImageCacheStorage(cache: cacheStorage)
      let apiClient = APIClientLive(session: URLSession(configuration: .default))
      let imageClient = ImageClientLive(apiClient: apiClient, cacheStorage: imageCacheStorage)
      let marketClient = MarketClientLive(apiClient: apiClient)
      let marketHomeViewModel = MarketHomeViewModel(marketClient: marketClient, imageClient: imageClient)

      MarketHomeView(viewModel: marketHomeViewModel)
    }
  }
}
