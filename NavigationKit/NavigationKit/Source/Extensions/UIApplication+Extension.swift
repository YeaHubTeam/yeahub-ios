import UIKit

public extension UIApplication {
    /// Return window from the first Scene of the Application. `SceneDelegate` must implement the `CustomSceneDelegate` protocol

    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    static var openSettingsURL: URL {
        URL(string: UIApplication.openSettingsURLString)!
    }

    /// Return the topmost navigation controller
    static func topNavigationController(
        _ controller: UIViewController? = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    ) -> UINavigationControllerType? {
        let currentNavigation = controller as? UINavigationControllerType
        if let tabController = controller as? UITabBarController {
            let moreNavigationController = tabController.moreNavigationController
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return moreNavigationController
            } else if let selected = tabController.selectedViewController {
                return topNavigationController(selected) ?? currentNavigation
            }
        } else if let presented = controller?.presentedViewController, !presented.isBeingDismissed {
            return topNavigationController(presented) ?? currentNavigation
        }
        return currentNavigation
    }
    
    /// Return the topmost view controller on the specified view controller.
    ///
    /// - Parameter controller: Specified controller to get topmost one.  If `nil`, the window's root view controller will be used.
    static func topViewController(
        _ controller: UIViewController? = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    ) -> UIViewController? {
        if let container = controller as? TopViewControllerSource {
            if let containee = container.topViewController() {
                return topViewController(containee)
            }
        } else if let presented = controller?.presentedViewController,
                  !presented.isBeingDismissed {
            return topViewController(presented)
        }
        return controller?.validPresentingController
    }
    
    static func isPresentingModal(_ controller: UIViewController? = UIApplication.keyWindow?.rootViewController) -> Bool {
        if let container = controller as? TopViewControllerSource {
            if let containee = container.topViewController() {
                // for navigation controller topViewController may be a modal already
                guard containee.presentingViewController == nil else {
                    return true
                }

                return isPresentingModal(containee)
            }
        }

        return controller?.presentedViewController != nil
    }
    
    var keyWindow: UIWindow? {
        return connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    var safeAreaInsets: UIEdgeInsets {
        return keyWindow?.safeAreaInsets ?? .zero
    }

}

private extension UIViewController {

    var validPresentingController: UIViewController? {
        if isBeingDismissed {
            presentingViewController?.validPresentingController
        } else {
            self
        }
    }
}
