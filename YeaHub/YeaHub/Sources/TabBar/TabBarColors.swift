import UIKit

// MARK: - TabBarColors
public struct TabBarColors: Equatable {

    public var background: UIColor
    public var items: TabBarItemColors
    
    public init(background: UIColor, items: TabBarItemColors) {
        self.background = background
        self.items = items
    }

    public static let light = Self(
        background: .systemBackground,
        items: TabBarItemColors(
            unselected: .systemGray,
            selected: .systemBlue
        )
    )

    public static let dark = Self(
        background: .systemBackground,
        items: TabBarItemColors(
            unselected: .systemGray2,
            selected: .systemBlue
        )
    )

    public static var `default` = Self.light
}

public struct TabBarItemColors: Equatable {

    public var unselected: UIColor
    public var selected: UIColor
    public var badge: UIColor
    
    public init(unselected: UIColor, selected: UIColor, badge: UIColor = .systemRed) {
        self.unselected = unselected
        self.selected = selected
        self.badge = badge
    }
}
