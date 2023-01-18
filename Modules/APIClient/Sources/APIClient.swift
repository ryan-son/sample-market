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
