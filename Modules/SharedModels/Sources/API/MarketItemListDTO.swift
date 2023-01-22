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
      searchValue: String? = nil
    ) {
      self.pageNumber = pageNumber
      self.itemsPerPage = itemsPerPage
      self.searchValue = searchValue
    }
  }

  public struct Response: Decodable {
    public let pageNo: Int
    public let itemsPerPage: Int
    public let totalCount: Int
    public let offset: Int
    public let limit: Int
    public let lastPage: Int
    public let hasNext: Bool
    public let hasPrev: Bool
    public let pages: [MarketItemDTO.Response]

    public init(
      pageNo: Int,
      itemsPerPage: Int,
      totalCount: Int,
      offset: Int,
      limit: Int,
      lastPage: Int,
      hasNext: Bool,
      hasPrev: Bool,
      pages: [MarketItemDTO.Response]
    ) {
      self.pageNo = pageNo
      self.itemsPerPage = itemsPerPage
      self.totalCount = totalCount
      self.offset = offset
      self.limit = limit
      self.lastPage = lastPage
      self.hasNext = hasNext
      self.hasPrev = hasPrev
      self.pages = pages
    }
  }
}

public struct MarketItemList {
  public let pageNumber: Int
  public let itemsPerPage: Int
  public let totalCount: Int
  public let offset: Int
  public let limit: Int
  public let lastPage: Int
  public let hasNextPage: Bool
  public let hasPreviousPage: Bool
  public let items: [MarketItem]
}

extension MarketItemListDTO.Response {
  public func toDomain() -> MarketItemList {
    return MarketItemList(
      pageNumber: pageNo,
      itemsPerPage: itemsPerPage,
      totalCount: totalCount,
      offset: offset,
      limit: limit,
      lastPage: lastPage,
      hasNextPage: hasNext,
      hasPreviousPage: hasPrev,
      items: pages.map { $0.toDomain() }
    )
  }
}
