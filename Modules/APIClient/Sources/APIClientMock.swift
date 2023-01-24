//
//  APIClientMock.swift
//  APIClient
//
//  Created by Geonhee on 2023/01/18.
//

#if DEBUG
import Foundation

public final class APIClientMock: APIClient {

  public init() {}

  public func request(_ route: APIRoutable) async throws -> APIResponse {
    let request = try URLRequest(route: route)
    let sampleResponse = URLResponse(
      url: request.url!,
      mimeType: nil,
      expectedContentLength: route.sampleData.count,
      textEncodingName: nil
    )
    return APIResponse(route.sampleData, sampleResponse)
  }

  public func request(url: URL) async throws -> APIResponse {
    let request = URLRequest(url: url)
    let sampleResponse = URLResponse(
      url: request.url!,
      mimeType: nil,
      expectedContentLength: 0,
      textEncodingName: nil
    )
    return APIResponse(Data(), sampleResponse)
  }
}
#endif
