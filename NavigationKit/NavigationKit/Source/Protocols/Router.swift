import Combine
import UIKit

/// Describes object that handles all navigation operations
public protocol Router {

    // MARK: - Modal presentation

    func present(_ presentable: Presentable?)
    func present(_ presentable: Presentable?, style: UIModalPresentationStyle?)
    func present(_ presentable: Presentable?, style: UIModalPresentationStyle?, animated: Bool, completion: (() -> Void)?)
    func present(
        _ presentable: Presentable?,
        style: UIModalPresentationStyle?,
        delegate: UIViewControllerTransitioningDelegate?,
        animated: Bool,
        completion: (() -> Void)?
    )
    func presentWithAnimation(_ presentable: Presentable?)

    var isPresentingModal: Bool { get }

    func dismiss()
    func dismiss(from presentable: Presentable?)
    func dismiss(from presentable: Presentable?, animated: Bool)
    func dismiss(from presentable: Presentable?, completion: (() -> Void)?)
    func dismiss(from presentable: Presentable?, animated: Bool, completion: (() -> Void)?)
    func dismiss(_ presentable: Presentable?, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func dismissAll(animated: Bool, completion: (() -> Void)?)
    func dismissAll(animated: Bool)
    func dismissWithAnimation(isDismissAll: Bool, completion: (() -> Void)?)

    // MARK: - Stack presentation

    func push(_ presentable: Presentable?)
    func push(_ presentable: Presentable?, animated: Bool)
    func push(_ presentable: Presentable?, animated: Bool, completion: @escaping () -> Void)

    func push(_ presentables: [Presentable?])
    func push(_ presentables: [Presentable?], animated: Bool)
    func push(_ presentables: [Presentable?], animated: Bool, completion: (() -> Void)?)

    func pop()
    func pop(animated: Bool)
    func pop(animated: Bool, completion: @escaping () -> Void)
    func pop(times controllersToPop: Int)
    func pop(times controllersToPop: Int, animated: Bool)
    func pop(times controllersToPop: Int, animated: Bool, completion: (() -> Void)?)

    func pop(from presentable: Presentable, animated: Bool)

    func pop(to presentable: Presentable)
    func pop(to presentable: Presentable, animated: Bool)
    func pop(to presentable: Presentable, animated: Bool, completion: (() -> Void)?)
    func popToRoot(animated: Bool)
    func popToRoot(animated: Bool, completion: @escaping () -> Void)

    func push(_ presentable: Presentable?, insteadFirstOf currentPresentable: [Presentable?], animated: Bool, completion: (() -> Void)?)

    /// Finds the first view controller of type in the navigation stack.
    func find(_ type: UIViewController.Type) -> UIViewController?

    /// Finds the first view controller of protocol in the navigation stack.
    func find<T>(conformingTo protocol: T.Type) -> UIViewController?

    /// Finds the last view controller of type in the navigation stack.
    func findLast(_ viewControllerType: UIViewController.Type) -> UIViewController?

    /// Finds the last view controller of protocol in the navigation stack.
    func findLast<T>(conformingTo protocol: T.Type) -> UIViewController?

    /// Finds the how many times you need to pop to get to view controller of protocol in navigation stack.
    func findReverseIndex<T>(conformingTo protocol: T.Type) -> Int?

    /// Find view controller recursively
    func findRecursively(_ type: UIViewController.Type) -> UIViewController?

    /// Returns the previous view controller in the navigation stack
    func previousVC() -> UIViewController?

    /// Returns the current view controller in the navigation stack
    func currentVC() -> UIViewController?

    /// Checks if the top view controller is of type.
    func isTop(_ type: UIViewController.Type) -> Bool
    /// Checks if the root view controller is of type
    func isRoot(_ type: UIViewController.Type) -> Bool
    func isRoot(_ viewContoller: UIViewController) -> Bool

    // MARK: - Root presentation

    func setNavigationStackRoot(_ presentable: Presentable?, animated: Bool)
    func setNavigationStackRoot(_ presentable: Presentable?, animated: Bool, isTopNavigationController: Bool)
    func setRoot(_ presentable: Presentable?)
    func setRoot(_ presentable: Presentable?, animated: Bool)
    var isNavigationStackRootOnTop: Bool { get }

    // MARK: - URL

    func open(url: URL, completion: ((Bool) -> Void)?)
    func open(urlString: String)

    // MARK: - Window

    var isEnabled: Bool { get nonmutating set }
    var window: UIWindow? { get }
}

public extension Router {

    // swiftlint:disable unused_setter_value
    var isEnabled: Bool {
        get { true }
        nonmutating set {}
    }

    // swiftlint:enable unused_setter_value

    func push(_ presentable: Presentable?, insteadFirstOf currentPresentable: [Presentable?], animated: Bool = true) {
        push(presentable, insteadFirstOf: currentPresentable, animated: animated, completion: nil)
    }

    func open(url: URL) {
        open(url: url, completion: nil)
    }

    func push(_ presentables: [Presentable?]) {
        push(presentables, animated: true, completion: nil)
    }

    func push(_ presentables: [Presentable?], animated: Bool) {
        push(presentables, animated: animated, completion: nil)
    }
}
