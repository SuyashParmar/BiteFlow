import UIKit

enum BFFont {
    static func title1(weight: UIFont.Weight = .bold) -> UIFont {
        let font = UIFont.systemFont(ofSize: 28, weight: weight)
        return UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
    }
    
    static func title2(weight: UIFont.Weight = .bold) -> UIFont {
        let font = UIFont.systemFont(ofSize: 22, weight: weight)
        return UIFontMetrics(forTextStyle: .title2).scaledFont(for: font)
    }
    
    static func title3(weight: UIFont.Weight = .semibold) -> UIFont {
        let font = UIFont.systemFont(ofSize: 20, weight: weight)
        return UIFontMetrics(forTextStyle: .title3).scaledFont(for: font)
    }
    
    static func headline(weight: UIFont.Weight = .semibold) -> UIFont {
        let font = UIFont.systemFont(ofSize: 17, weight: weight)
        return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
    }
    
    static func body(weight: UIFont.Weight = .regular) -> UIFont {
        let font = UIFont.systemFont(ofSize: 15, weight: weight)
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    
    static func callout(weight: UIFont.Weight = .regular) -> UIFont {
        let font = UIFont.systemFont(ofSize: 14, weight: weight)
        return UIFontMetrics(forTextStyle: .callout).scaledFont(for: font)
    }
    
    static func caption(weight: UIFont.Weight = .regular) -> UIFont {
        let font = UIFont.systemFont(ofSize: 12, weight: weight)
        return UIFontMetrics(forTextStyle: .caption1).scaledFont(for: font)
    }
}
