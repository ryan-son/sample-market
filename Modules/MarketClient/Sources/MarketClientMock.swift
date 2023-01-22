//
//  MarketClientMock.swift
//  MarketClientTests
//
//  Created by Geonhee on 2023/01/18.
//

#if DEBUG
import APIClient
import SharedModels

public final class MarketClientMock: MarketClient {

  private let apiClient: APIClient

  public init(
    apiClient: APIClient = APIClientMock()
  ) {
    self.apiClient = apiClient
  }

  public func itemList(request: MarketItemListDTO.Request) async throws -> MarketItemList {
    return MarketItemListDTO.Response.mock.toDomain()
  }
}

extension MarketItemDTO.Response {
  static let mock1 = MarketItemDTO.Response(
    id: 1775,
    vendorID: 11,
    vendorName: "borysarang",
    name: "AirPods(2세대)",
    description: "무료 각인 서비스\n\n이모티콘, 이름, 이니셜, 숫자를 조합한 각인으로 나만의 AirPods 만들기. 오직 Apple에서만.",
    thumbnail: "https://s3.ap-northeast-2.amazonaws.com/media.yagom-academy.kr/training-resources/11/20230203/dba78af0a3bd11edbe1007ad79a78491_thumb.png",
    currency: "KRW",
    price: 199000,
    bargainPrice: 199000,
    discountedPrice: 0,
    stock: 1,
    createdAt: "2023-02-03T00:00:00",
    issuedAt: "2023-02-03T00:00:00"
  )
  static let mock2 = MarketItemDTO.Response(
    id: 1774,
    vendorID: 11,
    vendorName: "borysarang",
    name: "Apple Watch SE",
    description: "알루미늄 케이스는 가볍고 100% 재활용된 항공우주 등급의 합금으로 만들어집니다.\n\n앞뒤가 다른 두 개의 나일론 레이어로 짜여 부드럽고 통기성이 좋은 스포츠 루프. 구조는 후크 앤드 루프 패스너 타입이라 빠르고 간편하게 길이 조절을 할 수 있습니다.\n\n",
    thumbnail: "https://s3.ap-northeast-2.amazonaws.com/media.yagom-academy.kr/training-resources/11/20230203/b6b11c1da3bd11edbe108f62c5ead27f_thumb.png",
    currency: "KRW",
    price: 359000,
    bargainPrice: 359000,
    discountedPrice: 0,
    stock: 1,
    createdAt: "2023-02-03T00:00:00",
    issuedAt: "2023-02-03T00:00:00"
  )
}

extension MarketItemListDTO.Response {
  static let mock = MarketItemListDTO.Response(
    pageNo: 1,
    itemsPerPage: 10,
    totalCount: 1167,
    offset: 0,
    limit: 10,
    lastPage: 117,
    hasNext: true,
    hasPrev: false,
    pages: [
      .mock1,
      .mock2
    ]
  )
}
#endif
