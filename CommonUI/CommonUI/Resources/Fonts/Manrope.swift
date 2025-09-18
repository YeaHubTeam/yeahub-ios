import SwiftUI
import UIKit

public extension Font {

    enum ManropeWeight {
        case light
        case regular
        case medium
        case bold
        case semibold
        case extraBold
    }

    /// Manrope
    static func manrope(_ weight: ManropeWeight = .regular, size: CGFloat = 16) -> Font {
        switch weight {
        case .light:
            return Font.custom("Manrope-Light", size: size)
        case .regular:
            return Font.custom("Manrope-Regular", size: size)
        case .medium:
            return Font.custom("Manrope-Medium", size: size)
        case .bold:
            return Font.custom("Manrope-Bold", size: size)
        case .semibold:
            return Font.custom("Manrope-SemiBold", size: size)
        case .extraBold:
            return Font.custom("Manrope-ExtraBold", size: size)
        }
    }

}

public extension UIFont {
    enum ManropeWeight {
        case light
        case regular
        case medium
        case bold
        case semibold
        case extraBold
    }

    static func manrope(_ weight: ManropeWeight = .regular, size: CGFloat = 16) -> UIFont {
        let fontName: String

        switch weight {
        case .light:
            fontName = "Manrope-Light"
        case .regular:
            fontName = "Manrope-Regular"
        case .medium:
            fontName = "Manrope-Medium"
        case .bold:
            fontName = "Manrope-Bold"
        case .semibold:
            fontName = "Manrope-SemiBold"
        case .extraBold:
            fontName = "Manrope-ExtraBold"
        }

        guard let font = UIFont(name: fontName, size: size) else {
            assertionFailure("Шрифт \(fontName) не найден. Убедитесь, что он добавлен в проект.")
            return UIFont.systemFont(ofSize: size)
        }

        return font
    }

    static func manropeDynamic(_ weight: ManropeWeight = .regular, style: UIFont.TextStyle) -> UIFont {
        let baseSize: CGFloat = switch style {
        case .largeTitle: 34
        case .title1: 28
        case .title2: 22
        case .title3: 20
        case .headline: 17
        case .body: 17
        case .callout: 16
        case .subheadline: 15
        case .footnote: 13
        case .caption1: 12
        case .caption2: 11
        default: 17
        }

        let font = UIFont.manrope(weight, size: baseSize)
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
}
