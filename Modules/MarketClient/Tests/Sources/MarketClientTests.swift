import Foundation
import XCTest
import SharedModels

@testable import MarketClient

final class MarketClientCoreTests: XCTestCase {

  private var sut: MarketClient!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MarketClientLive()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_itemList() async throws {
    let request = MarketItemListDTO.Request(pageNumber: 1, itemsPerPage: 10)
    let result = try await sut.itemList(request: request)
    print(result)
    XCTAssertTrue(!result.items.isEmpty)
  }
}
