import SwiftUI

extension Font {
  public static func pretendard(
    _ style: PretendardStyle,
    fixedSize: CGFloat
  ) -> Font {
    return Font.custom(style.rawValue, fixedSize: fixedSize)
  }

  public static func pretendard(
    _ style: PretendardStyle,
    size: CGFloat,
    relativeTo textStyle: TextStyle = .body
  ) -> Font {
    return Font.custom(style.rawValue, size: size, relativeTo: textStyle)
  }

  public enum PretendardStyle: String {
    case bold = "Pretendard-Bold"
    case regular = "Pretendard-Regular"
    case semiBold = "Pretendard-SemiBold"
  }
}
