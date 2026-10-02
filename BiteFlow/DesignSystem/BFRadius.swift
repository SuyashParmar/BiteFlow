import Foundation

enum BFRadius {
    /// 4.0
    static let s: CGFloat = 4.0
    /// 8.0
    static let m: CGFloat = 8.0
    /// 12.0
    static let l: CGFloat = 12.0
    /// 16.0
    static let xl: CGFloat = 16.0
    /// 24.0
    static let xxl: CGFloat = 24.0
    /// Full rounded (half of height)
    static func full(_ height: CGFloat) -> CGFloat {
        return height / 2.0
    }
}
