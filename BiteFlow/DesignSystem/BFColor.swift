import UIKit

enum BFColor {
    // Primary brand colors
    static let primary = UIColor(hex: "#FF5A5F") // A modern food app red/coral
    static let secondary = UIColor(hex: "#00A699") // Teal/green
    
    // Backgrounds
    static let background = UIColor.systemBackground
    static let secondaryBackground = UIColor.secondarySystemBackground
    static let tertiaryBackground = UIColor.tertiarySystemBackground
    
    // Text
    static let textPrimary = UIColor.label
    static let textSecondary = UIColor.secondaryLabel
    static let textTertiary = UIColor.tertiaryLabel
    
    // Status
    static let success = UIColor.systemGreen
    static let warning = UIColor.systemOrange
    static let error = UIColor.systemRed
    static let info = UIColor.systemBlue
    
    // Borders & Dividers
    static let border = UIColor.separator
    static let divider = UIColor.opaqueSeparator
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
