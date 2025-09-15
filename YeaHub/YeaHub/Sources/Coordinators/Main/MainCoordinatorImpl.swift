import SwiftUI
import NavigationKit
import CommonUI
import SharedScreens

class MainCoordinatorImpl: BaseCoordinator, MainCoordinator {

    var factory: MainFactory

    private weak var tabBarController: UITabBarController?
    private let router: Router

    private var childCoordinators: [Coordinator] = []

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
        let tabBarController = YHTabBarController()
        self.tabBarController = tabBarController

        configureTabs(for: tabBarController)

        router.setRoot(tabBarController, animated: true)
    }

    private func wrapWithStatusBarController(_ viewController: UIViewController) -> UIViewController {
        if let hostingController = viewController as? UIHostingController<AnyView> {
            return StatusBarHostingController(
                rootView: hostingController.rootView,
                hideStatusBar: true
            )
        }
        return StatusBarWrapperViewController(
            wrappedViewController: viewController,
            hideStatusBar: true
        )
    }

    private func configureTabs(for tabBarController: UITabBarController) {
        // Создаем координаторы
        let homeCoordinator = factory.makeHomeCoordinator(router: router)
        let questionsCoordinator = factory.makeQuestionsOnboardingCoordinator(router: router)
        let collectionsCoordinator = factory.makeCollectionsCoordinator(router: router)

        childCoordinators.append(homeCoordinator)
        childCoordinators.append(questionsCoordinator)
        childCoordinators.append(collectionsCoordinator)

        homeCoordinator.start()
        questionsCoordinator.start()
        collectionsCoordinator.start()

        guard let homeVC = homeCoordinator.getHomeScreen()?.toPresent(),
              let questionsVC = questionsCoordinator.getQuestionsOnboardingScreen()?.toPresent(),
              let collectionsVC = collectionsCoordinator.getCollectionScreen()?.toPresent()
        else {
            return
        }

        // Простая обертка - все контроллеры со скрытым статус баром
        let wrappedHomeVC = wrapWithStatusBarController(homeVC)
        let wrappedQuestionsVC = wrapWithStatusBarController(questionsVC)
        let wrappedCollectionsVC = wrapWithStatusBarController(collectionsVC)

        let homeNav: UINavigationControllerType
        if let nav = wrappedHomeVC as? UINavigationController {
            homeNav = nav
        } else {
            homeNav = UINavigationController(rootViewController: wrappedHomeVC)
        }

        homeNav.tabBarItem = UITabBarItem(
            title: "Коллекции",
            image: CommonUIAssets.collectionsVCImageTabBarLogo,
            tag: 0
        )

        let questionsNav: UINavigationControllerType
        if let nav = wrappedQuestionsVC as? UINavigationController {
            questionsNav = nav
        } else {
            questionsNav = UINavigationController(rootViewController: wrappedQuestionsVC)
        }

        questionsNav.tabBarItem = UITabBarItem(
            title: "Коллекции",
            image: CommonUIAssets.collectionsVCImageTabBarLogo,
            tag: 0
        )

        let collectionsNav: UINavigationControllerType
        if let nav = wrappedCollectionsVC as? UINavigationController {
            collectionsNav = nav
        } else {
            collectionsNav = UINavigationController(rootViewController: wrappedCollectionsVC)
        }

        collectionsNav.tabBarItem = UITabBarItem(
            title: "Коллекции",
            image: CommonUIAssets.collectionsVCImageTabBarLogo,
            tag: 0
        )

        tabBarController.viewControllers = [homeNav, questionsNav, collectionsNav]
    }

    func openFirstTab() {
        tabBarController?.selectedIndex = 0
    }
}
