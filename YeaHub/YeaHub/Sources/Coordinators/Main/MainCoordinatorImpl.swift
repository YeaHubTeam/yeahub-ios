import SwiftUI
import NavigationKit
import CommonUI

class MainCoordinatorImpl: BaseCoordinator, MainCoordinator {

    var factory: MainFactory

    private weak var tabBarController: UITabBarController?
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
//        let collectionsCoordinator = factory.makeCollectionsCoordinator(router: router)

        homeCoordinator.start()
        questionsCoordinator.start()
//        collectionsCoordinator.start()

        let collectionsVC = UIViewController()
        guard let homeVC = homeCoordinator.getHomeScreen()?.toPresent(),
              let questionsVC = questionsCoordinator.getQuestionsOnboardingScreen()?.toPresent()
//              let collectionsVC = collectionsCoordinator.toPresent()
        else {
            return
        }

        // Простая обертка - все контроллеры со скрытым статус баром
        let wrappedHomeVC = wrapWithStatusBarController(homeVC)
        let wrappedQuestionsVC = wrapWithStatusBarController(questionsVC)
        let wrappedCollectionsVC = wrapWithStatusBarController(collectionsVC)

        // Настраиваем табы
        wrappedHomeVC.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        // Центральный таб - оставляем пустым, так как у нас кастомная кнопка
        wrappedQuestionsVC.tabBarItem = UITabBarItem(
            title: "Вопросы",
            image: nil,
            selectedImage: nil
        )

        wrappedCollectionsVC.tabBarItem = UITabBarItem(
            title: "Коллекции",
            image: UIImage(systemName: "square.stack.3d.up"),
            selectedImage: UIImage(systemName: "square.stack.3d.up.fill")
        )

        tabBarController.viewControllers = [wrappedHomeVC, wrappedQuestionsVC, wrappedCollectionsVC]
    }

    func openFirstTab() {
        tabBarController?.selectedIndex = 0
    }
}
