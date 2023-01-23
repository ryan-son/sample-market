import MarketHomeCore
import SwiftUI

public struct MarketHomeView: View {

  @ObservedObject private var viewModel: MarketHomeViewModel

  public init(viewModel: MarketHomeViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    return EmptyView()
  }
}
