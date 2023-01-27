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
    VStack {
      List(viewModel.marketItems) { item in
        MarketHomeListRow(viewModel: viewModel, viewState: item.toViewState())
          .onAppear {
            if item == viewModel.marketItems.last {
              Task {
                await viewModel.fetchItemList()
              }
            }
          }

      }
      if viewModel.isLoading {
        ProgressView()
          .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
      }
    }
    .task {
      await viewModel.fetchItemList()
    }
  }
}

private struct MarketHomeListRow: View {

  struct ViewState {
    var thumbnailURLString: String
    var itemName: String
    var registeredDate: String
    var price: String
  }

  @State private var thumbnail: Image?
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
      AsyncImage(
        url: URL(string: viewState.thumbnailURLString),
        content: { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        },
        placeholder: {
          ProgressView()
            .frame(width: 100, height: 100)
        }
      )

      VStack(alignment: .leading, spacing: 10) {
        Text(viewState.itemName)
          .font(.headline)

        HStack(spacing: 8) {
          Text(viewState.price)
        }
      }
    }
    .task {
      guard let imageData = await viewModel.fetchThumbnailImage(for: viewState.thumbnailURLString),
            let uiImage = UIImage(data: imageData) else { return }
      thumbnail = Image(uiImage: uiImage)
    }
  }

  @ViewBuilder
  private func thumbnailImage() -> some View {
    if let thumbnail {
      thumbnail
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 100)
    } else {
      Image(systemName: "questionmark")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 100)
    }
  }
}

extension MarketItem {
  fileprivate func toViewState() -> MarketHomeListRow.ViewState {
    return MarketHomeListRow.ViewState(
      thumbnailURLString: thumbnail,
      itemName: name,
      registeredDate: "\(createdDate ?? Date())",
      price: "\(currency.rawValue.uppercased()) \(price.value.formatted(.number))"
    )
  }
}
