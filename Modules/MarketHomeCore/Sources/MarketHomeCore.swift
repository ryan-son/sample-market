import Foundation
import ImageClient
import MarketClient
import SharedModels

public final class MarketHomeViewModel: ObservableObject {

  public enum Error: Swift.Error {
    case underlying(Swift.Error)
  }

  private let marketClient: MarketClient
  private let imageClient: ImageClient
  @Published public var marketItems: [MarketItem]
  @Published public var isLoading: Bool = true
  @Published public var error: Error?

  private var currentPageNumber: Int

  public init(
    marketClient: MarketClient,
    imageClient: ImageClient,
    marketItems: [MarketItem] = [],
    currentPageNumber: Int = 0
  ) {
    self.marketClient = marketClient
    self.imageClient = imageClient
    self.marketItems = marketItems
    self.currentPageNumber = currentPageNumber
  }

  @MainActor
  @discardableResult
  public func fetchItemList(
    pageNumber: Int? = nil,
    itemsPerPage: Int = 10,
    searchValue: String? = nil
  ) async -> MarketItemList? {
    isLoading = true

    let request = MarketItemListDTO.Request(
      pageNumber: currentPageNumber + 1,
      itemsPerPage: 10,
      searchValue: searchValue
    )

    do {
      let fetchedItemList = try await marketClient.itemList(request: request)
      currentPageNumber = fetchedItemList.pageNumber
      marketItems += fetchedItemList.items
      isLoading = false
      return fetchedItemList
    } catch {
      self.error = .underlying(error)
      printIfDebug(error)
      return nil
    }
  }

  @MainActor
  public func fetchThumbnailImage(for urlString: String) async -> Data? {
    do {
      return try await imageClient.image(urlString: urlString)
    } catch {
      self.error = .underlying(error)
      printIfDebug(error)
      return nil
    }
  }
}

private func printIfDebug(_ items: Any...) {
  #if DEBUG
  print(items)
  #endif
}
