import Foundation
import MarketClient
import SharedModels
import XCTest

@testable import MarketHomeCore

final class MarketHomeCoreTests: XCTestCase {

  private var sut: MarketHomeViewModel!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MarketHomeViewModelLive(marketClient: MarketClientMock())
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_fetchItemList() async throws {
    // Given
    let pageNumber: Int? = nil // trigger default behavior
    let itemsPerPage: Int = 10
    let searchValue: String? = nil

    // When
    let result = await sut.fetchItemList(
      pageNumber: pageNumber,
      itemsPerPage: itemsPerPage,
      searchValue: searchValue
    )

    guard let result else {
      XCTFail("Failed to load item list")
      return
    }

    // Then
    XCTAssertTrue(!result.items.isEmpty)
    XCTAssertEqual(result.pageNumber, 1)
    XCTAssertEqual(result.itemsPerPage, itemsPerPage)
  }
}
