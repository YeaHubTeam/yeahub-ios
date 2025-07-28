import SwiftUI

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
