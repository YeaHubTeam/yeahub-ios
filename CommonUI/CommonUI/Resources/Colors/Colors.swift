import SwiftUI

public extension Color {

    // MARK: - Статические цвета

    static let purple700 = Color(hex: "#6A0BFF")
    static let black900 = Color(hex: "#191919")
    static let black800 = Color(hex: "#303030")
    static let black700 = Color(hex: "#474747")
    static let black600 = Color(hex: "#5E5E5E")
    static let black300 = Color(hex: "#A3A3A3")
    static let black50 = Color(hex: "#E8E8E8")
    static let black25 = Color(hex: "#F4F4F4")
    static let black10 = Color(hex: "#F5F5F5")
    static let pureWhite = Color(hex: "#FFFFFF")
    static let gray700 = Color(hex: "#6A6376")
    static let textBlack = Color(hex: "#141414")

    // MARK: - Адаптивные цвета (инверсия для темной темы)

    static let backgroundPrimary = adaptiveColor(light: .pureWhite, dark: .black900)
    static let backgroundSecondary = adaptiveColor(light: .black10, dark: .black900.opacity(0.8))
    static let textPrimary = adaptiveColor(light: .black900, dark: .pureWhite)
    static let textSecondary = adaptiveColor(light: .black50, dark: .black10)

    // MARK: - Вспомогательные методы

    private static func adaptiveColor(light: Color, dark: Color) -> Color {
        #if canImport(UIKit)
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
        #else
        return light // Для macOS используем только светлую тему
        #endif
    }

}

// MARK: - Конвертация для UIKit

extension UIColor {

    convenience init(_ color: Color) {
        self.init(color, dynamicProvider: nil)
    }

    convenience init(_ color: Color, dynamicProvider: ((UITraitCollection) -> UIColor)? = nil) {
        if let dynamicProvider {
            self.init { trait in
                dynamicProvider(trait)
            }
        } else {
            self.init(color)
        }
    }

}
