import Combine
import SafariServices
import UIKit

// swiftlint:disable type_body_length
/// Main class with default UIKit navigation primitives. Implements Router protocol
public class MainRouter: Router {

    public init() {}
    
    // MARK: - Private Properties

    private var topNavigationController: UINavigationControllerType? {
        UIApplication.topNavigationController()
    }
    
    private var tabBarController: UITabBarController? {
        window?.rootViewController as? UITabBarController
    }

    private var topViewController: UIViewController? {
        UIApplication.topViewController()
    }

    // MARK: - Internal properties

    var navigationController: UINavigationControllerType? {
        if let tabBar = window?.rootViewController as? UITabBarController {
            let moreNavigationController = tabBar.moreNavigationController
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return moreNavigationController
            } else if let selected = tabBar.selectedViewController {
                return selected as? UINavigationControllerType
            }
        }
        return window?.rootViewController as? UINavigationControllerType
    }

    public var isEnabled = true
    
    // MARK: - Router

    public var window: UIWindow? {
        UIApplication.keyWindow
    }

    // MARK: - Modal presentation

    public func present(_ presentable: Presentable?) {
        present(presentable, style: nil, animated: true, completion: nil)
    }

    public func present(_ presentable: Presentable?, style: UIModalPresentationStyle? = nil) {
        guard isEnabled, let controller = presentable?.toPresent() else {
            return
        }
        if let style {
            controller.modalPresentationStyle = style
        }
        topViewController?.present(controller, animated: true, completion: nil)
    }
    
    public func present(_ presentable: Presentable?, style: UIModalPresentationStyle? = nil, animated: Bool, completion: (() -> Void)?) {
        guard isEnabled, let controller = presentable?.toPresent() else {
            completion?()
            return
        }
        if let style {
            controller.modalPresentationStyle = style
        }
        topViewController?.present(controller, animated: animated, completion: completion)
    }

    public func present(
        _ presentable: Presentable?,
        style: UIModalPresentationStyle?,
        delegate: UIViewControllerTransitioningDelegate?,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        guard isEnabled, let controller = presentable?.toPresent() else {
            completion?()
            return
        }
        if let style {
            controller.modalPresentationStyle = style
        }
        if let delegate {
            controller.transitioningDelegate = delegate
        }
        topViewController?.present(controller, animated: animated, completion: completion)
    }

    public func presentWithAnimation(_ presentable: Presentable?) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        window?.layer.add(transition, forKey: kCATransition)
        present(presentable, animated: false, completion: nil)
    }

    public func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    public func dismiss(from presentable: Presentable?) {
        guard isEnabled else { return }
        presentable?.toPresent()?.dismiss(animated: true, completion: nil)
    }

    public func dismiss(from presentable: Presentable?, animated: Bool) {
        guard isEnabled else { return }
        presentable?.toPresent()?.dismiss(animated: animated, completion: nil)
    }

    public func dismiss(from presentable: Presentable?, completion: (() -> Void)?) {
        guard isEnabled else {
            completion?()
            return
        }
        presentable?.toPresent()?.dismiss(animated: true, completion: completion)
    }

    public func dismiss(from presentable: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard isEnabled else {
            completion?()
            return
        }
        presentable?.toPresent()?.dismiss(animated: animated, completion: completion)
    }

    public func dismiss(_ presentable: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard isEnabled, let controller = presentable?.toPresent() else {
            completion?()
            return
        }
        if let presenting = controller.presentingViewController {
            presenting.dismiss(animated: animated, completion: completion)
        } else {
            controller.dismiss(animated: animated, completion: completion)
        }
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        guard isEnabled else {
            completion?()
            return
        }
        topViewController?.dismiss(animated: animated, completion: completion)
    }

    public func dismissAll(animated: Bool, completion: (() -> Void)?) {
        guard isEnabled, tabBarController?.presentedViewController != nil else {
            completion?()
            return
        }
        tabBarController?.dismiss(animated: animated, completion: completion)
    }

    public func dismissAll(animated: Bool) {
        guard isEnabled, tabBarController?.presentedViewController != nil else {
            return
        }
        tabBarController?.dismiss(animated: animated)
    }

    public func dismissWithAnimation(isDismissAll: Bool, completion: (() -> Void)?) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        window?.layer.add(transition, forKey: nil)
        if isDismissAll {
            dismissAll(animated: false, completion: completion)
        } else {
            dismiss(animated: false, completion: completion)
        }
    }

    // MARK: - Stack presentation

    public func push(_ presentable: Presentable?) {
        push(presentable, animated: true)
    }

    public func push(_ presentable: Presentable?, animated: Bool) {
        push(presentable, animated: animated) {}
    }

    public func push(_ presentable: Presentable?, animated: Bool, completion: @escaping () -> Void) {
        guard isEnabled, let controller = presentable?.toPresent(), let topNavigationController else {
            completion()
            return
        }
        topNavigationController.push(controller, animated: animated, completion: completion)
    }

    public func push(_ presentables: [Presentable?], animated: Bool, completion: (() -> Void)?) {
        guard isEnabled, let topNavigationController else {
            completion?()
            return
        }

        let controllersToPush = presentables
            .compactMap { $0?.toPresent() }

        guard controllersToPush.isNotEmpty else {
            completion?()
            return
        }

        let duplicatedControllers = topNavigationController
            .viewControllers
            .filter(controllersToPush.contains(_:))

        guard duplicatedControllers.isEmpty else {
            assertionFailure("Unable to push controllers that are already on the navigation stack: \(duplicatedControllers)")
            completion?()
            return
        }

        var newNavigationStack = topNavigationController.viewControllers
        newNavigationStack.append(contentsOf: controllersToPush)
        topNavigationController.setViewControllers(newNavigationStack, animated: animated, completion: completion)
    }

    public func pop() {
        pop(animated: true)
    }

    public func pop(animated: Bool) {
        guard isEnabled else { return }
        _ = topNavigationController?.pop(animated: animated, completion: nil)
    }

    public func pop(from presentable: Presentable, animated: Bool) {
        guard let controller = presentable.toPresent() else { return }

        controller.navigationController?.popViewController(animated: animated)
    }

    public func pop(animated: Bool, completion: @escaping () -> Void) {
        guard isEnabled else {
            completion()
            return
        }
        _ = topNavigationController?.pop(animated: animated, completion: completion)
    }

    public func pop(to presentable: Presentable) {
        pop(to: presentable, animated: true, completion: nil)
    }

    public func pop(to presentable: Presentable, animated: Bool) {
        pop(to: presentable, animated: animated, completion: nil)
    }

    public func pop(to presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        guard isEnabled, let controller = presentable.toPresent() else {
            completion?()
            return
        }
        guard topNavigationController?.viewControllers.contains(controller) == true else {
            completion?()
            return
        }
        _ = topNavigationController?.popToViewController(controller, animated: animated, completion: completion)
    }

    public func pop(times controllersToPop: Int) {
        pop(times: controllersToPop, animated: true)
    }

    public func pop(times controllersToPop: Int, animated: Bool) {
        pop(times: controllersToPop, animated: animated, completion: nil)
    }

    public func pop(times controllersToPop: Int, animated: Bool, completion: (() -> Void)?) {
        guard isEnabled else {
            completion?()
            return
        }
        topNavigationController?.pop(times: controllersToPop, animated: animated, completion: completion)
    }

    public func popPreviousView() {
        guard
            isEnabled,
            var controllers = topNavigationController?.viewControllers,
            controllers.count >= 3
        else {
            return
        }
        controllers.remove(at: controllers.count - 2)
        topNavigationController?.setViewControllers(controllers, animated: true)
    }

    public func push(_ presentable: Presentable?, insteadFirstOf currentPresentable: [Presentable?], animated: Bool, completion: (() -> Void)?) {
        guard isEnabled else {
            completion?()
            return
        }
        let currentControllers = currentPresentable.compactMap { $0?.toPresent() }
        guard
            let navigation = topNavigationController,
            let index = navigation.viewControllers.firstIndex(where: currentControllers.contains)
        else {
            push(presentable, animated: animated, completion: completion ?? {})
            return
        }
        if let push = presentable?.toPresent() {
            navigation.setViewControllers(
                Array(navigation.viewControllers.prefix(index)) + [push],
                animated: animated,
                completion: completion
            )
        } else {
            _ = navigation.popToViewController(navigation.viewControllers[max(0, index - 1)], animated: animated, completion: completion)
        }
    }

    public func popToRoot(animated: Bool) {
        guard isEnabled else { return }
        _ = topNavigationController?.popToRoot(animated: animated, completion: nil)
    }

    public func popToRoot(animated: Bool, completion: @escaping () -> Void) {
        guard isEnabled else {
            completion()
            return
        }
        _ = topNavigationController?.popToRoot(animated: animated, completion: completion)
    }

    public func find(_ viewControllerType: UIViewController.Type) -> UIViewController? {
        topNavigationController?.viewControllers.first { type(of: $0) == viewControllerType }
    }

    public func find<T>(conformingTo protocol: T.Type) -> UIViewController? {
        topNavigationController?.viewControllers.first { viewController in
            viewController is T
        }
    }

    public func findLast(_ viewControllerType: UIViewController.Type) -> UIViewController? {
        topNavigationController?.viewControllers.last { type(of: $0) == viewControllerType }
    }

    public func findLast<T>(conformingTo protocol: T.Type) -> UIViewController? {
        topNavigationController?.viewControllers.last { viewController in
            viewController is T
        }
    }

    public func findReverseIndex<T>(conformingTo protocol: T.Type) -> Int? {
        topNavigationController?.viewControllers.reversed().enumerated().first { viewController in
            viewController.element is T
        }?.offset
    }

    public func findRecursively(_ viewControllerType: UIViewController.Type) -> UIViewController? {
        guard var root = UIApplication.keyWindow?.rootViewController else { return nil }
        if type(of: root) == viewControllerType {
            return root
        }
        while let presented = root.presentedViewController {
            if type(of: presented) == viewControllerType {
                return presented
            }
            root = presented
        }
        return nil
    }

    public func previousVC() -> UIViewController? {
        guard let controllers = topNavigationController?.viewControllers else { return nil }
        return controllers[safe: controllers.count - 2]
    }

    public func currentVC() -> UIViewController? {
        topViewController
    }

    public func isTop(_ viewControllerType: UIViewController.Type) -> Bool {
        guard let last = topNavigationController?.viewControllers.last else { return false }
        return type(of: last) == viewControllerType
    }

    public func isRoot(_ viewControllerType: UIViewController.Type) -> Bool {
        guard let first = topNavigationController?.viewControllers.first else { return false }
        return type(of: first) == viewControllerType
    }

    public func isRoot(_ viewController: UIViewController) -> Bool {
        guard let first = topNavigationController?.viewControllers.first else { return false }
        return first === viewController
    }

    // MARK: - Root presentation

    public func setNavigationStackRoot(_ presentable: Presentable?, animated: Bool = false) {
        setNavigationStackRoot(presentable, animated: animated, isTopNavigationController: false)
    }

    public func setNavigationStackRoot(_ presentable: Presentable?, animated: Bool = false, isTopNavigationController: Bool) {
        guard isEnabled, let controller = presentable?.toPresent() else {
            return
        }
        let navVC = isTopNavigationController ? topNavigationController : navigationController
        navVC?.setViewControllers([controller], animated: animated)
    }

    public var isNavigationStackRootOnTop: Bool {
        navigationController?.viewControllers.count == 1
    }

    public var isPresentingModal: Bool {
        UIApplication.isPresentingModal()
    }

    public func setRoot(_ presentable: Presentable?) {
        setRoot(presentable, animated: false)
    }

    public func setRoot(_ presentable: Presentable?, animated: Bool) {
        let window = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive }
            .flatMap { $0 as? UIWindowScene }?
            .windows
            .first { $0.isKeyWindow } ?? UIApplication.shared.windows.first { $0.isKeyWindow }

        guard isEnabled, let window, let viewController = presentable?.toPresent() else { return }

        window.rootViewController = viewController
        window.makeKeyAndVisible()

        if animated {
            UIView.transition(
                with: window,
                duration: 0.6,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: nil
            )
        }
    }

    // MARK: - URL

    public func open(url: URL, completion: ((Bool) -> Void)? = nil) {
        guard UIApplication.shared.canOpenURL(url) else {
            completion?(false)
            return
        }
        UIApplication.shared.open(url)
        completion?(true)
    }

    public func open(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        open(url: url)
    }
}

// swiftlint:enable type_body_length
