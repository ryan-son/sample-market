//
//  MarketItemListDTO.swift
//  SharedModels
//
//  Created by Geonhee on 2023/01/12.
//

import Foundation

public enum MarketItemListDTO {

  public struct Request {
    let pageNumber: Int
    let itemsPerPage: Int
    let searchValue: String
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
