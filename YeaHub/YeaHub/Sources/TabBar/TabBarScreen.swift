import NavigationKit
import UIKit

public typealias TabBarScreen =
    Presentable &
    TabBarScreenInput & TabBarScreenOutput

public protocol TabBarScreenInput: AnyObject {

    var selectedIndex: Int { get }

    func set(_ presentables: Presentable...)
    func set(_ presentables: [Presentable])
    func select(tabIndex: Int)
    func updateItemFor<Tab>(tab: Tab, item: UITabBarItem) where Tab: RawRepresentable, Tab.RawValue == Int
}

public protocol TabBarScreenOutput: AnyObject {

    var onAppear: () -> Void { get set }
    var onChange: (TabChange) -> Void { get set }
    var onShouldSelect: ((_ index: Int, _ isTapped: Bool) -> Bool)? { get set }
}
