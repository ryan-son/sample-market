import MarketHomeCore
import SharedModels
import SwiftUI

public struct MarketHomeView: View {

  @ObservedObject private var viewModel: MarketHomeViewModel

  public init(
    viewModel: MarketHomeViewModel
  ) {
    self.viewModel = viewModel
  }

  public var body: some View {
    return EmptyView()
  }
}

private struct MarketHomeListCell: View {

  struct ViewState {
    var thumbnailURL: URL?
    var itemName: String
    var registeredDate: String
    var price: String
  }

  var body: some View {
    return EmptyView()
  }
}

extension MarketItem {
  private func toViewState() -> MarketHomeListCell.ViewState {
    return MarketHomeListCell.ViewState(
      thumbnailURL: URL(string: thumbnail),
      itemName: name,
      registeredDate: "\(createdDate ?? Date())",
      price: "\(currency) \(price.value.formatted(.number))"
    )
  }
}
