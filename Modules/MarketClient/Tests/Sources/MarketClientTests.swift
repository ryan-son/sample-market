import APIClient
import Foundation
import SMFoundation
import SharedModels
import XCTest

@testable import MarketClient

final class MarketClientCoreTests: XCTestCase {

  private var sut: MarketClient!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MarketClientLive(apiClient: APIClientMock())
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_itemList() async throws {
    // Given
    let request = MarketItemListDTO.Request(pageNumber: 1, itemsPerPage: 10)

    // When
    let result = try await sut.itemList(request: request)

    // Then
    XCTAssertTrue(result.items.isNotEmpty)
    XCTAssertEqual(result.pageNumber, request.pageNumber)
    XCTAssertEqual(result.itemsPerPage, request.itemsPerPage)
  }
}
