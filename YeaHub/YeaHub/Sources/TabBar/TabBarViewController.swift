import NavigationKit
import UIKit

open class TabBarViewController: UITabBarController,
    TabBarScreenInput,
    TabBarScreenOutput {

    private enum TabSwitchType {

        case tap
        case move
    }

    // MARK: - TabBarScreenOutput

    open var onAppear: () -> Void = { }
    open var onChange: (TabChange) -> Void = { _ in }
    open var onShouldSelect: ((_ index: Int, _ isTapped: Bool) -> Bool)?
    private var isFirstAppear = true
    open override var viewControllers: [UIViewController]? {
        didSet {
            didSetControllers()
        }
    }

    // MARK: - Private Properties

    private var previousIndex: Int?
    private let tabBarView = TabBarView()
    private var colors: TabBarColors = .default {
        didSet {
            guard oldValue != colors else { return }
            tabBarView.updateColors(colors, animated: view?.window != nil)
        }
    }

    // MARK: - UIViewController

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard isFirstAppear else { return }
        isFirstAppear = false
        onAppear()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.bringSubviewToFront(tabBarView)
    }

    // MARK: - TabBarScreenInput

    open func set(_ presentables: Presentable...) {
        viewControllers = presentables.compactMap { presentable in
            presentable.toPresent()
        }
    }

    open func set(_ presentables: [Presentable]) {
        viewControllers = presentables.compactMap { presentable in
            presentable.toPresent()
        }
    }

    open func select(
        tabIndex: Int
    ) {
        guard
            let viewController = viewControllers?[safe: tabIndex]
        else { return }
        let shouldSelect = shouldSelect(
            self,
            shouldSelect: viewController,
            switchType: .move
        )
        guard shouldSelect else { return }
        selectedIndex = tabIndex
        tabBarController(
            self,
            didSelect: viewController
        )
    }

    open override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        didSetControllers()
    }

    public func updateTabBarColors() {
        if let nav = selectedViewController as? UINavigationControllerType {
            colors = nav.topViewController?.tabBarColors ?? .default
        } else {
            colors = selectedViewController?.tabBarColors ?? .default
        }
    }

    public func updateItemFor<Tab>(tab: Tab, item: UITabBarItem) where Tab: RawRepresentable, Tab.RawValue == Int {
        let index = tab.rawValue
        guard let viewController = viewControllers?[safe: index] else { return }
        viewController.tabBarItem = item
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {

    public func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) {
        onChange(
            TabChange(
                previousIndex: previousIndex,
                currentIndex: selectedIndex
            )
        )
        previousIndex = selectedIndex
        didSetControllers()
    }

    public func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        shouldSelect(tabBarController, shouldSelect: viewController, switchType: .tap)
    }
}

// MARK: - Private Methods

private extension TabBarViewController {

    func setupView() {
        delegate = self
        view.backgroundColor = .white
        tabBar.addSubview(tabBarView)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false

        tabBarView.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        tabBarView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor).isActive = true
        tabBarView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor).isActive = true
        tabBarView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true

        tabBarView.frame = tabBar.bounds
        let defaultArea: CGFloat = UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0
        let defaultHeight = tabBar.frame.height + defaultArea
        let desiredHeight: CGFloat = TabBarView.Constants.tabsHeight +
        (
            defaultArea > 0
            ? TabBarView.Constants.safeAreaHeightLarge
            : TabBarView.Constants.safeAreaHeightSmall
        )
        additionalSafeAreaInsets.bottom = max(0, desiredHeight - defaultHeight)
        tabBar.setNeedsLayout()
        tabBar.setTransparent()
    }

    func didSetControllers() {
        tabBar.makeItemsTransparent()
        tabBarView.configure(
            with: TabBarView.Configuration(
                items: viewControllers?.compactMap(\.tabBarItem) ?? [],
                selectedIndex: selectedIndex,
                onSelect: { [weak self] in
                    self?.selectedIndex = $0
                },
                colors: colors
            )
        )
        updateTabBarColors()
    }

    private func shouldSelect(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController,
        switchType: TabSwitchType
    ) -> Bool {
        guard viewController != moreNavigationController else {
            return true
        }

        guard let index = viewControllers?.firstIndex(of: viewController) else {
            return false
        }

        return onShouldSelect?(index, switchType == .tap) ?? true
    }
}

private extension UITabBar {

    func setTransparent() {
        // iOS 15+ specific implementation

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear

        appearance.shadowColor = .clear

        // Make tab bar items transparent
        let itemAppearance = UITabBarItemAppearance()

        // Clear icons for both states
        itemAppearance.normal.iconColor = .clear
        itemAppearance.selected.iconColor = .clear

        // Clear text for both states
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]

        // Apply item appearance to all states
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        // Set appearance for both standard and scroll edge states
        standardAppearance = appearance
        scrollEdgeAppearance = appearance

        // Additional properties to ensure complete transparency
        tintColor = .clear
        unselectedItemTintColor = .clear

        // Remove any shadow or separator
        shadowImage = UIImage()
        backgroundImage = UIImage()
    }

    func makeItemsTransparent() {
        guard let items else { return }
        for item in items {
            // Make the item completely transparent
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
            item.image = item.image?.withTintColor(.clear, renderingMode: .alwaysOriginal)
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            item.selectedImage = item.selectedImage?.withTintColor(.clear, renderingMode: .alwaysOriginal)
            item.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
            item.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .selected)
        }
    }
}
