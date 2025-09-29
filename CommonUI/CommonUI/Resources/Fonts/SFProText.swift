import SwiftUI
import UIKit

public extension Font {

    enum SFProTextWeight {
        case regular
        case medium
        case semibold
    }

    static func sFProText(_ weight: SFProTextWeight = .regular, size: CGFloat = 16) -> Font {
        switch weight {
        case .regular:
            return Font.custom("SFProText-Regular", size: size)
        case .medium:
            return Font.custom("SFProText-Medium", size: size)
        case .semibold:
            return Font.custom("SFProText-Semibold", size: size)
        }
    }
}

public extension UIFont {
    enum SFProTextWeight {
        case regular
        case medium
        case semibold
    }

    static func sFProText(_ weight: SFProTextWeight = .regular, size: CGFloat = 16) -> UIFont {
        let fontName: String

        switch weight {
        case .regular:
            fontName = "SFProText-Regular"
        case .medium:
            fontName = "SFProText-Medium"
        case .semibold:
            fontName = "SFProText-Semibold"
        }

        guard let font = UIFont(name: fontName, size: size) else {
            assertionFailure("Шрифт \(fontName) не найден. Убедитесь, что он добавлен в проект.")
            return UIFont.systemFont(ofSize: size)
        }

        return font
    }

    static func sFProTextDynamic(_ weight: SFProTextWeight = .regular, style: UIFont.TextStyle) -> UIFont {
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

        let font = UIFont.sFProText(weight, size: baseSize)
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
}
