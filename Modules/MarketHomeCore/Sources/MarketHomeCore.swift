import Foundation
import MarketClient
import SharedModels

public final class MarketHomeViewModel: ObservableObject {

  enum Error: Swift.Error {
    case underlying(Swift.Error)
  }

  private let marketClient: MarketClient
  @Published private var marketItems: [MarketItem]
  @Published private var error: Error?

  private var currentPageNumber: Int

  public init(
    marketClient: MarketClient = MarketClientLive(),
    marketItems: [MarketItem] = [],
    currentPageNumber: Int = 0
  ) {
    self.marketClient = marketClient
    self.marketItems = marketItems
    self.currentPageNumber = currentPageNumber
  }

  public func fetchItemList(
    pageNumber: Int? = nil,
    itemsPerPage: Int = 10,
    searchValue: String? = nil
  ) async -> MarketItemList? {
    let request = MarketItemListDTO.Request(
      pageNumber: currentPageNumber + 1,
      itemsPerPage: 10,
      searchValue: searchValue
    )

    do {
      let fetchedItemList = try await marketClient.itemList(request: request)
      currentPageNumber = fetchedItemList.pageNumber
      marketItems = fetchedItemList.items
      return fetchedItemList
    } catch {
      self.error = .underlying(error)
      #if DEBUG
      print(error)
      #endif
      return nil
    }
  }
}
