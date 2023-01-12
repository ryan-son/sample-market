//
//  MarketItemDTO.swift
//  SharedModels
//
//  Created by Geonhee on 2023/01/12.
//

import Foundation

public enum MarketItemDTO {
  public struct Response: Decodable {
    let id: Int
    let vendorID: Int
    let venderName: Int
    let name: String
    let description: String
    let thumbnail: String
    let currency: Currency
    let price: Int
    let bargainPrice: Int
    let discountedPrice: Int
    let stock: Int
    let createdAt: Date
    let issuedAt: Date

    enum CodingKeys: String, CodingKey {
      case id
      case vendorID = "vendor_id"
      case venderName
      case name
      case description
      case thumbnail
      case currency
      case price
      case bargainPrice = "bargain_price"
      case discountedPrice = "discounted_price"
      case stock
      case createdAt = "created_at"
      case issuedAt = "issued_at"
    }
  }
}

extension MarketItemDTO.Response {
  func toDomain() -> MarketItem {
    return MarketItem(
      id: id,
      vendorID: vendorID,
      venderName: venderName,
      name: name,
      description: description,
      thumbnail: thumbnail,
      currency: currency,
      price: MarketItem.Price(value: price),
      bargainPrice: MarketItem.Price(value: bargainPrice),
      discountedPrice: MarketItem.Price(value: discountedPrice),
      stock: stock,
      createdDate: createdAt,
      issuedDate: issuedAt
    )
  }
}

public enum Currency: String, Decodable {
  case krw = "KRW"
  case usd = "USD"
}
