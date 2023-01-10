import Foundation

protocol APIClient {

}

public final class APIClientLive: APIClient {

  private let session: URLSession

  public init(session: URLSession) {
    self.session = session
  }

}
