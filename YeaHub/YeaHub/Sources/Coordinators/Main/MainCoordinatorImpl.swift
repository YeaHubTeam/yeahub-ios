import SwiftUI
import NavigationKit

class MainCoordinatorImpl: BaseCoordinator, MainCoordinator {

    var factory: MainFactory

    private var tabBarItems: [TabBarItem] = []
    private weak var tabBarScreen: TabBarScreen?
    private let router: Router

    init(
        router: Router,
        factory: MainFactory
    ) {
        self.router = router
        self.factory = factory
        super.init()
    }

    func start() {
        showTabBar()
    }

    private func showTabBar() {
        let screen = factory.makeTabBarScreen()
        tabBarScreen = screen

        tabBarScreen?.onAppear = { }

        tabBarScreen?.onChange = { _ in }

        tabBarScreen?.onShouldSelect = { _, _ in
            return true
        }

        configureTabs()

        setTabBarAsRoot(screen)
    }

    private func setTabBarAsRoot(_ screen: TabBarScreen) {
        // Получаем текущее key window
        let window = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive }
            .flatMap { $0 as? UIWindowScene }?
            .windows
            .first { $0.isKeyWindow } ?? UIApplication.shared.windows.first { $0.isKeyWindow }

        let tabBarController = screen.toPresent()

        if let window = window,
           let tabBarController = tabBarController {

            // Устанавливаем TabBarController как root в наше рабочее окно
            window.rootViewController = tabBarController

            // Убеждаемся, что окно остается key
            window.makeKeyAndVisible()
        } else {
            // Fallback к стандартному router, если по какой-то причине не найдем окно
            router.setRoot(screen, animated: true)
        }
    }

    private func configureTabs() {
        // Создаем табы с правильными элементами
        tabBarItems = [
            TabBarItem(
                slug: "home",
                page: "home",
                name: "Главная",
                image: UIImage(systemName: "house"),
                selectedImage: UIImage(systemName: "house.fill")
            ),
            TabBarItem(
                slug: "search",
                page: "search",
                name: "Поиск",
                image: UIImage(systemName: "magnifyingglass"),
                selectedImage: UIImage(systemName: "magnifyingglass")
            ),
            TabBarItem(
                slug: "favorites",
                page: "favorites",
                name: "Избранное",
                image: UIImage(systemName: "heart"),
                selectedImage: UIImage(systemName: "heart.fill")
            ),
            TabBarItem(
                slug: "profile",
                page: "profile",
                name: "Профиль",
                image: UIImage(systemName: "person"),
                selectedImage: UIImage(systemName: "person.fill")
            )
        ]

        // Создаем view controllers - используем HomeCoordinator для первого таба
        let homeCoordinator = factory.makeHomeCoordinator(router: router)
        homeCoordinator.start()

        let homeViewController = homeCoordinator.getHomeScreen()

        let searchViewController = createSimpleViewController(title: "Поиск", backgroundColor: .systemBlue)
        let favoritesViewController = createSimpleViewController(title: "Избранное", backgroundColor: .systemPurple)
        let profileViewController = createSimpleViewController(title: "Профиль", backgroundColor: .systemGreen)

        let viewControllers = [homeViewController, searchViewController, favoritesViewController, profileViewController]

        // Устанавливаем tabBarItem для каждого view controller
        for (index, viewController) in viewControllers.enumerated() where index < tabBarItems.count {
            if let viewController {
                viewController.tabBarItem = tabBarItems[index].tabBarItem()
            }
        }

        tabBarScreen?.set(viewControllers.compactMap { $0 })
        tabBarScreen?.select(tabIndex: 0)
    }

    // Нужно только для создания заглушек
    private func createSimpleViewController(title: String, backgroundColor: UIColor) -> UIViewController {
        let viewController = UIViewController()
        viewController.title = title
        viewController.view.backgroundColor = backgroundColor

        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        viewController.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])

        return viewController
    }

    private func handle(_ change: TabChange) {
        guard tabBarItems[safe: change.currentIndex] != nil else {
            return
        }
        // обработка смены таба
    }

    func openFirstTab(function: String = #function) {
        selectFirstTab(function: function)
    }

    @discardableResult
    func selectFirstTab(function: String) -> String? {
        guard let firstItem = tabBarItems.first else {
            return nil
        }

        tabBarScreen?.select(tabIndex: .zero)
        return firstItem.slug.value
    }
}
