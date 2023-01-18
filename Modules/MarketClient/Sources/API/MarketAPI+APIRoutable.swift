//
//  MarketAPI+APIRoutable.swift
//  MarketClient
//
//  Created by Geonhee on 2023/01/12.
//

import APIClient
import Foundation
import SharedModels

extension MarketAPI: APIRoutable {
  var baseURL: String {
    return "https://openmarket.yagom-academy.kr"
  }

  var route: Route {
    switch self {
    case let .itemList(request):
      var query = "page_no=\(request.pageNumber)"
      query += "&items_per_page=\(request.itemsPerPage)"

      if let searchValue = request.searchValue {
        query += "&search_value=\(searchValue)"
      }
      return .get("/api/products")
    }
  }

  var parameters: Parameters {
    switch self {
    case let .itemList(request):
      return Parameters(
        values: [
          "page_no": request.pageNumber,
          "items_per_page": request.itemsPerPage,
          "search_value": request.searchValue as Any
        ]
      )
    }
  }

  var headers: [String: String]? {
    return nil
  }
}
