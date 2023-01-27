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
    var thumbnailURLString: String
    var itemName: String
    var registeredDate: String
    var price: String
  }

  @State private var thumbnailImage: Image?
  private let viewModel: MarketHomeViewModel
  private let viewState: ViewState

  init(
    viewModel: MarketHomeViewModel,
    viewState: ViewState
  ) {
    self.viewModel = viewModel
    self.viewState = viewState
  }

  var body: some View {
    HStack(spacing: 15) {
      if let thumbnailImage {
        thumbnailImage
          .resizable()
          .aspectRatio(contentMode: .fit)
      } else {
        Image(systemName: "questionmark")
          .resizable()
          .aspectRatio(contentMode: .fit)
      }

      VStack(spacing: 10) {
        Text(viewState.itemName)

        HStack(spacing: 8) {
          Text(viewState.price)
          Text(viewState.registeredDate)
        }
      }
    }
    .task {
      guard let imageData = await viewModel.fetchThumbnailImage(for: viewState.thumbnailURLString),
            let uiImage = UIImage(data: imageData) else { return }
      thumbnailImage = Image(uiImage: uiImage)
    }
  }
}

extension MarketItem {
  private func toViewState() -> MarketHomeListCell.ViewState {
    return MarketHomeListCell.ViewState(
      thumbnailURLString: thumbnail,
      itemName: name,
      registeredDate: "\(createdDate ?? Date())",
      price: "\(currency) \(price.value.formatted(.number))"
    )
  }
}
