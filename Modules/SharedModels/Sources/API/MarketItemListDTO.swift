//
//  MarketItemListDTO.swift
//  SharedModels
//
//  Created by Geonhee on 2023/01/12.
//

import Foundation

public enum MarketItemListDTO {

  public struct Request {
    public let pageNumber: Int
    public let itemsPerPage: Int
    public let searchValue: String?

    public init(
      pageNumber: Int,
      itemsPerPage: Int,
      searchValue: String?
    ) {
      self.pageNumber = pageNumber
      self.itemsPerPage = itemsPerPage
      self.searchValue = searchValue
    }
  }

  public struct Response: Decodable {
    let pageNo: Int
    let itemsPerPage: Int
    let totalCount: Int
    let offset: Int
    let limit: Int
    let lastPage: Int
    let hasNext: Bool
    let hasPrev: Bool
    let pages: [MarketItemDTO.Response]
  }
}

public struct MarketItemList {
  let pageNumber: Int
  let itemsPerPage: Int
  let totalCount: Int
  let offset: Int
  let limit: Int
  let isLastPage: Int
  let hasNextPage: Bool
  let hasPreviousPage: Bool
  let items: [MarketItem]
}

extension MarketItemListDTO.Response {
  public func toDomain() -> MarketItemList {
    return MarketItemList(
      pageNumber: pageNo,
      itemsPerPage: itemsPerPage,
      totalCount: totalCount,
      offset: offset,
      limit: limit,
      isLastPage: lastPage,
      hasNextPage: hasNext,
      hasPreviousPage: hasPrev,
      items: pages.map { $0.toDomain() }
    )
  }
}
