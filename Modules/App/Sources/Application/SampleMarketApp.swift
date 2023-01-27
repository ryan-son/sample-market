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
      MarketHomeView(
        viewModel: MarketHomeViewModel(
          marketClient: MarketClientLive(),
          imageClient: ImageClientLive(
            apiClient: APIClientLive(session: URLSession(configuration: .default)),
            cacheStorage: ImageCacheStorage(
              cache: LRUCacheStorage(
                diskCache: LRUDiskCache(maxSize: 50 * 1024 * 1024),
                memoryCache: LRUMemoryCache(maxSize: 300 * 1024 * 1024)
              )
            )
          ),
          marketItems: []
        )
      )
    }
  }
}
