//
//  MarketClientMock.swift
//  MarketClientTests
//
//  Created by Geonhee on 2023/01/18.
//

// #if DEBUG
// import APIClient
// import SharedModels
//
// final class MarketClientMock: MarketClient {
//
//  private let apiClient: APIClient
//
//  public init(
//    apiClient: APIClient = APIClientMock()
//  ) {
//    self.apiClient = apiClient
//  }
//
//  func itemList(request: MarketItemListDTO.Request) async throws -> MarketItemList {
//    let response = try await apiClient.request(
//      MarketAPI.itemList(request),
//      as: MarketItemListDTO.Response.self
//    )
//    return try await apiClient.request(<#T##route: APIRoutable##APIRoutable#>, as: <#T##Decodable.Protocol#>)
//  }
// }
// #endif
