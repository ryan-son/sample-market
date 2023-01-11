import Foundation
import XCTest

@testable import APIClient

final class APIClientCoreTests: XCTestCase {

  private var sut: APIClient!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = APIClientLive(session: .shared)
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}
