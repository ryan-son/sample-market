//
//  MarketItem.swift
//  SharedModels
//
//  Created by Geonhee on 2023/01/12.
//

import Foundation

public struct MarketItem {

  public struct Price {
    let value: Int
  }

  let id: Int
  let vendorID: Int
  let venderName: Int
  let name: String
  let description: String
  let thumbnail: String
  let currency: Currency
  let price: Price
  let bargainPrice: Price
  let discountedPrice: Price
  let stock: Int
  let createdDate: Date
  let issuedDate: Date
}
