import Foundation

public protocol ImageClient {
  func image(urlString: String) async throws -> Data
}
