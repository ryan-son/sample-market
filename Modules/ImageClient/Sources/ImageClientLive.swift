//
//  ImageClientLive.swift
//  ImageClient
//
//  Created by Geonhee on 2023/01/28.
//

import APIClient
import ImageCacheStorage
import Foundation

public final class ImageClientLive: ImageClient {

  enum Error: Swift.Error {
    case invalidURL(String)
  }

  private let apiClient: APIClient
  private let cacheStorage: ImageCacheStorage

  public init(
    apiClient: APIClient,
    cacheStorage: ImageCacheStorage
  ) {
    self.apiClient = apiClient
    self.cacheStorage = cacheStorage
  }

  public func image(urlString: String) async throws -> Data {
    if let cached = cacheStorage.retrieve(for: urlString) {
      return cached
    } else {
      guard let url = URL(string: urlString) else {
        throw Error.invalidURL(urlString)
      }
      let imageData = try await apiClient.request(url: url).data
      cacheStorage.store(imageData, for: urlString)
      return imageData
    }
  }
}
