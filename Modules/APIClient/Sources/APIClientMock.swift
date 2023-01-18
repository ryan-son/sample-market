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
    let urlRequest = try URLRequest(route: route)
    let sampleResponse = URLResponse(
      url: urlRequest.url!,
      mimeType: nil,
      expectedContentLength: route.sampleData.count,
      textEncodingName: nil
    )
    return APIResponse(route.sampleData, sampleResponse)
  }
}
#endif
