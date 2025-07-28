import UIKit

public protocol UINavigationControllerType: UIViewController {

    var topViewController: UIViewController? { get }
    var visibleViewController: UIViewController? { get }
    var viewControllers: [UIViewController] { get }
    var navigationBar: UINavigationBar { get }
    var isNavigationBarHidden: Bool { get set }
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool, completion: (() -> Void)?) -> UIViewController?
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) -> [UIViewController]?
    func popToRoot(animated: Bool, completion: (() -> Void)?) -> [UIViewController]
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool, completion: (() -> Void)?)
    func setNavigationBarHidden(_ hidden: Bool, animated: Bool)
}

public extension UINavigationControllerType {

    @discardableResult
    func pop(
        times controllersToPop: Int,
        animated: Bool = true,
        completion: (() -> Void)?
    ) -> [UIViewController] {
        let result = viewControllers.suffix(controllersToPop)
        setViewControllers(
            Array(viewControllers.prefix(max(0, viewControllers.count - controllersToPop))),
            animated: animated,
            completion: completion
        )
        return Array(result)
    }
}
