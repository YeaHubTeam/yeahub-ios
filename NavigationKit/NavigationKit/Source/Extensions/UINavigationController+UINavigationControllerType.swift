import UIKit

extension UINavigationController: UINavigationControllerType {

    @discardableResult
    public func popToViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    ) -> [UIViewController]? {
        let result = popToViewController(viewController, animated: animated)
        if animated, let transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
        return result
    }

    public func push(
        _ viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        pushViewController(viewController, animated: animated)
        if animated, let transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }

    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool, completion: (() -> Void)?) {
        setViewControllers(viewControllers, animated: animated)
        if animated, let transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }

    @discardableResult
    public func pop(
        animated: Bool,
        completion: (() -> Void)?
    ) -> UIViewController? {
        let result = popViewController(animated: animated)
        if animated, let transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
        return result
    }

    @discardableResult
    public func popToRoot(
        animated: Bool,
        completion: (() -> Void)?
    ) -> [UIViewController] {
        let result = popToRootViewController(animated: animated) ?? []
        if animated, let transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
        return result
    }
}
