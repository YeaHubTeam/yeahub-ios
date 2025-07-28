import UIKit

public protocol TopViewControllerSource {

    func topViewController() -> UIViewController?
}

extension UINavigationController: TopViewControllerSource {

    public func topViewController() -> UIViewController? {
        visibleViewController
    }
}

extension UITabBarController: TopViewControllerSource {

    public func topViewController() -> UIViewController? {
        selectedViewController
    }
}
