//
//  MarketItem.swift
//  SharedModels
//
//  Created by Geonhee on 2023/01/12.
//

import Foundation

public struct MarketItem {

  public struct Price {
    public let value: Int
  }

  public let id: Int
  public let vendorID: Int
  public let venderName: String
  public let name: String
  public let description: String
  public let thumbnail: String
  public let currency: Currency
  public let price: Price
  public let bargainPrice: Price
  public let discountedPrice: Price
  public let stock: Int
  public let createdDate: Date?
  public let issuedDate: Date?
}
