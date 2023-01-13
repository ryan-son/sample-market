import APIClient
import SharedModels

public protocol MarketClient {
  func itemList(request: MarketItemListDTO.Request) async throws -> MarketItemList
}

public final class MarketClientLive: MarketClient {

  private let apiClient: APIClient

  public init(
    apiClient: APIClient = APIClientLive()
  ) {
    self.apiClient = apiClient
  }

  public func itemList(request: MarketItemListDTO.Request) async throws -> MarketItemList {
    let response = try await apiClient.request(
      MarketAPI.itemList(request),
      as: MarketItemListDTO.Response.self
    )
    return response.toDomain()
  }
}
