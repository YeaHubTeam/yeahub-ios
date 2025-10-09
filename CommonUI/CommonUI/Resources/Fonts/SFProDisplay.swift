import SwiftUI
import UIKit

public extension Font {

    enum SFProDisplayWeight {
        case medium
    }

    static func sFProDisplay(_ weight: SFProDisplayWeight = .medium, size: CGFloat = 16) -> Font {
        switch weight {
        case .medium:
            return Font.custom("SFProDisplay-Medium", size: size)
        }
    }
}

public extension UIFont {
    enum SFProDisplayWeight {
        case medium
    }

    static func sFProDisplay(_ weight: SFProDisplayWeight = .medium, size: CGFloat = 16) -> UIFont {
        let fontName: String

        switch weight {
        case .medium:
            fontName = "SFProDisplay-Medium"
        }

        guard let font = UIFont(name: fontName, size: size) else {
            assertionFailure("Шрифт \(fontName) не найден. Убедитесь, что он добавлен в проект.")
            return UIFont.systemFont(ofSize: size)
        }

        return font
    }

    static func sFProDisplayDynamic(_ weight: SFProDisplayWeight = .medium, style: UIFont.TextStyle) -> UIFont {
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

        let font = UIFont.sFProDisplay(weight, size: baseSize)
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
}
