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
    let vendorName: String
    let name: String
    let description: String
    let thumbnail: String
    let currency: String
    let price: Int
    let bargainPrice: Int
    let discountedPrice: Int
    let stock: Int
    let createdAt: String
    let issuedAt: String

    enum CodingKeys: String, CodingKey {
      case id
      case vendorID = "vendor_id"
      case vendorName
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
  static let sharedDateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter
  }()

  func toDomain() -> MarketItem {
    return MarketItem(
      id: id,
      vendorID: vendorID,
      venderName: vendorName,
      name: name,
      description: description,
      thumbnail: thumbnail,
      currency: Currency(rawValue: currency) ?? .krw,
      price: MarketItem.Price(value: price),
      bargainPrice: MarketItem.Price(value: bargainPrice),
      discountedPrice: MarketItem.Price(value: discountedPrice),
      stock: stock,
      createdDate: Self.sharedDateFormatter.date(from: createdAt),
      issuedDate: Self.sharedDateFormatter.date(from: issuedAt)
    )
  }
}

public enum Currency: String, Decodable {
  case krw = "KRW"
  case usd = "USD"
}
