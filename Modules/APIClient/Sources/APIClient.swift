import Foundation

public typealias APIResponse = (data: Data, urlResponse: URLResponse)

public protocol APIClient {
  func request(_ route: APIRoutable) async throws -> APIResponse
  func request<Decoded: Decodable>(
    _ route: APIRoutable,
    as decodedType: Decoded.Type
  ) async throws -> Decoded
}

public extension APIClient {
  func request<Decoded: Decodable>(
    _ route: APIRoutable,
    as decodedType: Decoded.Type
  ) async throws -> Decoded {
    let (data, _) = try await request(route)

    do {
      return try decode(Decoded.self, from: data)
    } catch {
      throw error
    }
  }

  func decode<Decoded: Decodable>(
    with decoder: JSONDecoder = JSONDecoder(),
    _ type: Decoded.Type,
    from data: Data
  ) throws -> Decoded {
    do {
      return try decoder.decode(Decoded.self, from: data)
    } catch {
      #if DEBUG
      print(error)
      #endif
      throw error
    }
  }
}

public final class APIClientLive: APIClient {

  private let session: URLSession

  public init(
    session: URLSession = URLSession(configuration: .default)
  ) {
    self.session = session
  }

  public func request(_ route: APIRoutable) async throws -> APIResponse {
    let urlRequest = URLRequest(route: route)!
    #if DEBUG
    printRequest(urlRequest)
    #endif
    let (data, response) = try await session.data(for: urlRequest)
    #if DEBUG
    printAPI(request: urlRequest, response: (data, response))
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

fileprivate extension URLComponents {
  init?(route: APIRoutable) {
    self.init(string: route.baseURL)
    self.path = route.route.path
    self.queryItems = route.parameters.toQueryItems()
  }
}

fileprivate extension URLRequest {
  init?(route: APIRoutable) {
    guard let url = URLComponents(route: route)?.url else { return nil }
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
