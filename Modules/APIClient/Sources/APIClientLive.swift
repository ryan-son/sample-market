//
//  APIClientLive.swift
//  APIClient
//
//  Created by Geonhee on 2023/01/18.
//

import Foundation

public final class APIClientLive: APIClient {

  private let session: URLSession

  public init(
    session: URLSession = URLSession(configuration: .default)
  ) {
    self.session = session
  }

  public func request(_ route: APIRoutable) async throws -> APIResponse {
    let request = try URLRequest(route: route)
    return try await data(for: request)
  }

  public func request(url: URL) async throws -> APIResponse {
    let request = URLRequest(url: url)
    return try await data(for: request)

  }

  private func data(for request: URLRequest) async throws -> APIResponse {
    #if DEBUG
    printRequest(request)
    #endif
    let (data, response) = try await session.data(for: request)
    #if DEBUG
    printAPI(request: request, response: (data, response))
    #endif
    return (data, response)
  }

  private func printRequest(_ request: URLRequest) {
    print(
      "🟨 Request route: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")"
    )
  }
  private func printAPI(
    request: URLRequest,
    response: (data: Data, urlResponse: URLResponse)
  ) {
    print(
      """
      ✅ Response route: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? ""), \
      status: \((response.urlResponse as? HTTPURLResponse)?.statusCode ?? 0), \
      receive data: \(response.data.asPrettyPrinted ?? ""))
      """
    )
  }
}

// MARK: - Helpers

fileprivate extension URLComponents {
  init?(route: APIRoutable) {
    self.init(string: route.baseURL)
    self.path = route.route.path
    self.queryItems = route.parameters.toQueryItems()
  }
}

extension URLRequest {
  enum Error: Swift.Error {
    case invalidRoute(APIRoutable)
  }

  init(route: APIRoutable) throws {
    guard let url = URLComponents(route: route)?.url else { throw Self.Error.invalidRoute(route) }
    self.init(url: url)
    self.httpMethod = route.route.method.rawValue
    self.allHTTPHeaderFields = route.headers
  }
}

fileprivate extension Data {
  var asPrettyPrinted: String? {
    guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
          let stringified = String(data: data, encoding: .utf8) else { return nil }
    return stringified
  }
}
