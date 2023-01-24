import APIClient
import Foundation

public protocol ImageClient {
  func image(urlString: String) async throws -> Data
}

public final class ImageClientLive: ImageClient {

  enum Error: Swift.Error {
    case invalidURLString(String)
  }

  private let apiClient: APIClient

  public init(
    apiClient: APIClient = APIClientLive()
  ) {
    self.apiClient = apiClient
  }

  public func image(urlString: String) async throws -> Data {
    guard let url = URL(string: urlString) else {
      throw Error.invalidURLString(urlString)
    }
    return try await apiClient.request(url: url).data
  }
}
