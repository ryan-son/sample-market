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
  var baseURL: URL {
    return URL(string: "https://openmarket.yagom-academy.kr")!
  }

  var route: Route {
    switch self {
    case let .itemList(request):
      var query = "page_no=\(request.pageNumber)"
      query += "&items_per_page=\(request.itemsPerPage)"

      if let searchValue = request.searchValue {
        query += "&search_value=\(searchValue)"
      }
      return .get("/api/products?\(query)")
    }
  }

  var headers: [String: String]? {
    return nil
  }
}
