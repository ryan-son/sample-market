//
//  MarketItemDTO.swift
//  SharedModels
//
//  Created by Geonhee on 2023/01/12.
//

import Foundation

public enum MarketItemDTO {
  public struct Response: Decodable {
    public let id: Int
    public let vendorID: Int
    public let vendorName: String
    public let name: String
    public let description: String
    public let thumbnail: String
    public let currency: String
    public let price: Double
    public let bargainPrice: Double
    public let discountedPrice: Double
    public let stock: Int
    public let createdAt: String
    public let issuedAt: String

    public init(
      id: Int,
      vendorID: Int,
      vendorName: String,
      name: String,
      description: String,
      thumbnail: String,
      currency: String,
      price: Double,
      bargainPrice: Double,
      discountedPrice: Double,
      stock: Int,
      createdAt: String,
      issuedAt: String
    ) {
      self.id = id
      self.vendorID = vendorID
      self.vendorName = vendorName
      self.name = name
      self.description = description
      self.thumbnail = thumbnail
      self.currency = currency
      self.price = price
      self.bargainPrice = bargainPrice
      self.discountedPrice = discountedPrice
      self.stock = stock
      self.createdAt = createdAt
      self.issuedAt = issuedAt
    }

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
