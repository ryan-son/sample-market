import Foundation
import XCTest

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
//    sut.
  }
}
