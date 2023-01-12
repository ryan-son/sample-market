import APIClient

public protocol MarketClient {

}

public final class MarketClientLive: MarketClient {

  private let apiClient: APIClient

  public init(
    apiClient: APIClient = APIClientLive()
  ) {
    self.apiClient = apiClient
  }

}
